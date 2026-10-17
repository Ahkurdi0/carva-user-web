"use client";

import { useEffect } from "react";
import { usePathname } from "next/navigation";

/**
 * Scroll reveal for every [data-reveal] element on the page (cards, rows,
 * tiles): they rise into place as they come on screen, staggered when
 * several arrive together. New elements (infinite lists) are picked up as
 * they are added. Nothing happens with Reduce Motion.
 */
export function RevealObserver() {
  const pathname = usePathname();

  useEffect(() => {
    if (typeof window === "undefined" || !("IntersectionObserver" in window)) return;
    if (window.matchMedia("(prefers-reduced-motion: reduce)").matches) return;
    document.documentElement.classList.add("reveal-on");

    const io = new IntersectionObserver(
      (entries) => {
        let i = 0;
        for (const en of entries) {
          if (!en.isIntersecting) continue;
          const el = en.target as HTMLElement;
          el.style.setProperty("--reveal-delay", `${Math.min(i, 6) * 60}ms`);
          el.setAttribute("data-shown", "");
          io.unobserve(el);
          i++;
        }
      },
      { rootMargin: "0px 0px -6% 0px", threshold: 0.08 },
    );
    const watch = (root: ParentNode) =>
      root.querySelectorAll<HTMLElement>("[data-reveal]:not([data-shown])").forEach((el) => io.observe(el));
    watch(document);
    const mo = new MutationObserver((muts) => {
      for (const m of muts)
        m.addedNodes.forEach((n) => {
          if (!(n instanceof HTMLElement)) return;
          if (n.matches("[data-reveal]:not([data-shown])")) io.observe(n);
          watch(n);
        });
    });
    mo.observe(document.body, { childList: true, subtree: true });
    return () => {
      io.disconnect();
      mo.disconnect();
    };
  }, [pathname]);

  return null;
}
