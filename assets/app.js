import "./preline/preline";
import { HSStaticMethods } from "./preline/preline";

export const hooks = {
  ThemeSwitcher: {
    mounted() {
      this.el.addEventListener("click", () => {
        const theme = localStorage.getItem("theme") ?? "light";
        const newTheme = theme === "dark" ? "light" : "dark";

        document.documentElement.classList.toggle("dark", newTheme === "dark");
        localStorage.setItem("theme", newTheme);
      });
    },
  },
  Accordion: {
    mounted() {
      HSStaticMethods.autoInit(["accordion"]);
    },
    updated() {
      HSStaticMethods.autoInit(["accordion"]);
    },
    destroyed() {
      this.el.remove();
    },
  },
};

export const dom = {
  onBeforeElUpdated(fromEl, toEl) {
    if (fromEl.classList.contains("hs-accordion")) {
      toEl.className = fromEl.className;
    }
  },
};
