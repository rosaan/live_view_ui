export * from "./src/hooks";

export const dom = {
  onBeforeElUpdated(fromEl, toEl) {
    if (fromEl.classList.contains("hs-accordion")) {
      toEl.className = fromEl.className;
    }
  },
};
