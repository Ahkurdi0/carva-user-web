"use client";

import { create } from "zustand";
import { chatApi } from "./chat";

/** Unread chat messages for the nav badge; refreshed by polling and after reading a chat. */
export const useChatUnread = create<{ count: number; refresh: () => Promise<void>; reset: () => void }>((set) => ({
  count: 0,
  refresh: async () => {
    try {
      const { count } = await chatApi.unread();
      set({ count });
    } catch {
      /* signed out or offline: keep the last value */
    }
  },
  reset: () => set({ count: 0 }),
}));
