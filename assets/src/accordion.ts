export const AccordionHook = {
  mounted() {
    import("preline/src/plugins/accordion").then((module) => {
      module?.default?.autoInit();
    });
  },
  updated() {
    import("preline/src/plugins/accordion").then((module) => {
      module?.default?.autoInit();
    });
  },
};
