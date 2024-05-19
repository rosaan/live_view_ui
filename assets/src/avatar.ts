export const AvatarHook = {
  mounted() {
    const image = this.el.querySelector("img");

    image.addEventListener("load", () => {
      image.style.display = "block";
    });

    image.addEventListener("error", () => {
      image.style.display = "none";
    });
  },
  updated() {
    const image = this.el.querySelector("img");

    image.addEventListener("load", () => {
      image.style.display = "block";
    });

    image.addEventListener("error", () => {
      image.style.display = "none";
    });
  },
};
