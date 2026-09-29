"use client";

/**
 * Web push through OneSignal — the same OneSignal app the User and Company
 * mobile apps use, so the server's existing pushes (chat replies, admin
 * announcements) also reach the browser without any server change.
 *
 * The SDK is loaded from OneSignal's CDN on first use; nothing loads when
 * NEXT_PUBLIC_ONESIGNAL_APP_ID is unset, so local/dev builds stay quiet.
 * Setup: add a "Web" platform for https://carvarent.com in the OneSignal
 * dashboard, then set NEXT_PUBLIC_ONESIGNAL_APP_ID at build time.
 */

const APP_ID = process.env.NEXT_PUBLIC_ONESIGNAL_APP_ID ?? "";
const SDK_URL = "https://cdn.onesignal.com/sdks/web/v16/OneSignalSDK.page.js";

interface OneSignalSdk {
  init(options: Record<string, unknown>): Promise<void>;
  login(externalId: string): Promise<void>;
  logout(): Promise<void>;
  Notifications: {
    permission: boolean;
    isPushSupported(): boolean;
    requestPermission(): Promise<void>;
    addEventListener(event: "permissionChange", cb: (granted: boolean) => void): void;
    addEventListener(
      event: "click",
      cb: (e: { notification: { additionalData?: Record<string, unknown> } }) => void,
    ): void;
  };
  User: {
    PushSubscription: {
      optedIn?: boolean;
      optIn(): Promise<void>;
      optOut(): Promise<void>;
    };
  };
}

declare global {
  interface Window {
    OneSignalDeferred?: ((sdk: OneSignalSdk) => void | Promise<void>)[];
  }
}

let ready: Promise<OneSignalSdk | null> | null = null;

export const pushConfigured = () => APP_ID.length > 0;

/** Browser can receive push at all (not e.g. iOS Safari outside a home-screen app). */
export const pushSupported = () =>
  typeof window !== "undefined" && "Notification" in window && "serviceWorker" in navigator;

/** Loads and initialises the SDK once; resolves null when push is unavailable. */
function sdk(): Promise<OneSignalSdk | null> {
  if (!pushConfigured() || !pushSupported()) return Promise.resolve(null);
  if (ready) return ready;
  ready = new Promise((resolve) => {
    window.OneSignalDeferred = window.OneSignalDeferred || [];
    window.OneSignalDeferred.push(async (os) => {
      try {
        await os.init({
          appId: APP_ID,
          serviceWorkerPath: "OneSignalSDKWorker.js",
          allowLocalhostAsSecureOrigin: true,
          // We show our own prompt (NotificationPrompt) instead of OneSignal's.
          notifyButton: { enable: false },
          welcomeNotification: { disable: true },
        });
        // Chat pushes carry { type: "chat", conversationId }: open that chat.
        os.Notifications.addEventListener("click", (e) => {
          const data = e.notification.additionalData;
          if (data?.type === "chat" && typeof data.conversationId === "string") {
            window.location.href = `/chats/${data.conversationId}`;
          }
        });
        resolve(os);
      } catch {
        resolve(null);
      }
    });
    const script = document.createElement("script");
    script.src = SDK_URL;
    script.defer = true;
    script.onerror = () => resolve(null);
    document.head.appendChild(script);
  });
  return ready;
}

export type PushState = "unsupported" | "blocked" | "off" | "on";

export async function pushState(): Promise<PushState> {
  const os = await sdk();
  if (!os) return "unsupported";
  if (Notification.permission === "denied") return "blocked";
  return Notification.permission === "granted" && os.User.PushSubscription.optedIn ? "on" : "off";
}

/** Links this browser to the signed-in account so user-targeted pushes arrive here. */
export async function pushLogin(userId: string) {
  const os = await sdk();
  await os?.login(userId).catch(() => {});
}

export async function pushLogout() {
  const os = await sdk();
  await os?.logout().catch(() => {});
}

/** Asks the browser for permission (must run from a click) and subscribes. */
export async function enablePush(): Promise<PushState> {
  const os = await sdk();
  if (!os) return "unsupported";
  if (Notification.permission !== "granted") {
    await os.Notifications.requestPermission().catch(() => {});
  }
  if (Notification.permission === "granted") {
    await os.User.PushSubscription.optIn().catch(() => {});
  }
  return pushState();
}

export async function disablePush(): Promise<PushState> {
  const os = await sdk();
  await os?.User.PushSubscription.optOut().catch(() => {});
  return pushState();
}
