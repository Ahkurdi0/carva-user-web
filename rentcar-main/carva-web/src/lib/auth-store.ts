"use client";

import { create } from "zustand";
import { api, tokens } from "./api";
import type { AuthResult, Profile } from "./types";

interface AuthState {
  user: Profile | null;
  /** true until the initial session check (refresh) finishes. */
  loading: boolean;
  setUser: (u: Profile | null) => void;
  /** Store tokens + profile after a login/signup response. */
  signIn: (res: AuthResult) => void;
  /** Re-validate the session on app start using the stored refresh token. */
  hydrate: () => Promise<void>;
  logout: (allDevices?: boolean) => Promise<void>;
  /** Convenience permission check (admins implicitly allowed). */
  can: (permission: string) => boolean;
  isAdmin: () => boolean;
  isCompany: () => boolean;
}

function splitAuth(res: AuthResult): Profile {
  const { accessToken: _a, refreshToken: _r, ...profile } = res;
  void _a;
  void _r;
  return profile;
}

export const useAuth = create<AuthState>((set, get) => ({
  user: null,
  loading: true,

  setUser: (user) => set({ user }),

  signIn: (res) => {
    tokens.set(res.accessToken, res.refreshToken);
    set({ user: splitAuth(res), loading: false });
  },

  hydrate: async () => {
    if (!tokens.access && !tokens.refresh) {
      set({ user: null, loading: false });
      return;
    }
    try {
      const profile = await api.json<Profile>("/auth/refresh", undefined);
      set({ user: profile, loading: false });
    } catch {
      tokens.clear();
      set({ user: null, loading: false });
    }
  },

  logout: async (allDevices = false) => {
    try {
      await api.json("/auth/logout", { allDevices });
    } catch {
      /* best effort */
    }
    tokens.clear();
    set({ user: null });
  },

  can: (permission) => {
    const u = get().user;
    if (!u) return false;
    if (u.role?.roleName === "admin") return true;
    return !!u.permissions?.some((p) => p.permission.permissionName === permission);
  },

  isAdmin: () => get().user?.role?.roleName === "admin",
  isCompany: () => !!get().user?.company,
}));
