"use client";

import { useEffect } from "react";
import { I18nProvider } from "@/i18n";
import { useAuth } from "@/lib/auth-store";
import { VisitTracker } from "./VisitTracker";

function SessionGate({ children }: { children: React.ReactNode }) {
  const hydrate = useAuth((s) => s.hydrate);
  const setUser = useAuth((s) => s.setUser);

  useEffect(() => {
    hydrate();
    const onLogout = () => setUser(null);
    window.addEventListener("carva:logout", onLogout);
    return () => window.removeEventListener("carva:logout", onLogout);
  }, [hydrate, setUser]);

  return <>{children}</>;
}

export function Providers({ children }: { children: React.ReactNode }) {
  return (
    <I18nProvider>
      <SessionGate>{children}</SessionGate>
      <VisitTracker />
    </I18nProvider>
  );
}
