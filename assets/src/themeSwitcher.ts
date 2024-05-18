export const ThemeSwitcherHook = {
  mounted() {
    this.el.addEventListener("click", () => {
      const theme = localStorage.getItem("theme") ?? "light";
      const newTheme = theme === "dark" ? "light" : "dark";

      document.documentElement.classList.toggle("dark", newTheme === "dark");
      localStorage.setItem("theme", newTheme);
    });
  },
};
