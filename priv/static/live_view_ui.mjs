var __defProp = Object.defineProperty;
var __getOwnPropNames = Object.getOwnPropertyNames;
var __esm = (fn, res) => function __init() {
  return fn && (res = (0, fn[__getOwnPropNames(fn)[0]])(fn = 0)), res;
};
var __export = (target, all) => {
  for (var name in all)
    __defProp(target, name, { get: all[name], enumerable: true });
};

// node_modules/preline/src/utils/index.ts
var dispatch, afterTransition;
var init_utils = __esm({
  "node_modules/preline/src/utils/index.ts"() {
    dispatch = (evt, element, payload = null) => {
      const event = new CustomEvent(evt, {
        detail: { payload },
        bubbles: true,
        cancelable: true,
        composed: false
      });
      element.dispatchEvent(event);
    };
    afterTransition = (el, callback) => {
      const handleEvent = () => {
        callback();
        el.removeEventListener("transitionend", handleEvent, true);
      };
      const hasTransition = window.getComputedStyle(el, null).getPropertyValue("transition") !== (navigator.userAgent.includes("Firefox") ? "all" : "all 0s ease 0s");
      if (hasTransition)
        el.addEventListener("transitionend", handleEvent, true);
      else
        callback();
    };
  }
});

// node_modules/preline/src/plugins/base-plugin/index.ts
var HSBasePlugin;
var init_base_plugin = __esm({
  "node_modules/preline/src/plugins/base-plugin/index.ts"() {
    HSBasePlugin = class {
      constructor(el, options, events) {
        this.el = el;
        this.options = options;
        this.events = events;
        this.el = el;
        this.options = options;
        this.events = {};
      }
      createCollection(collection, element) {
        collection.push({
          id: element?.el?.id || collection.length + 1,
          element
        });
      }
      fireEvent(evt, payload = null) {
        if (this.events.hasOwnProperty(evt))
          return this.events[evt](payload);
      }
      on(evt, cb) {
        this.events[evt] = cb;
      }
    };
  }
});

// node_modules/preline/src/plugins/accordion/index.ts
var accordion_exports = {};
__export(accordion_exports, {
  default: () => accordion_default
});
var HSAccordion, accordion_default;
var init_accordion = __esm({
  "node_modules/preline/src/plugins/accordion/index.ts"() {
    init_utils();
    init_base_plugin();
    HSAccordion = class extends HSBasePlugin {
      constructor(el, options, events) {
        super(el, options, events);
        this.toggle = this.el.querySelector(".hs-accordion-toggle") || null;
        this.content = this.el.querySelector(".hs-accordion-content") || null;
        this.group = this.el.closest(".hs-accordion-group") || null;
        this.isAlwaysOpened = this.group.hasAttribute("data-hs-accordion-always-open") || false;
        if (this.toggle && this.content)
          this.init();
      }
      init() {
        this.createCollection(window.$hsAccordionCollection, this);
        this.toggle.addEventListener("click", () => {
          if (this.el.classList.contains("active")) {
            this.hide();
          } else {
            this.show();
          }
        });
      }
      // Public methods
      show() {
        if (this.group && !this.isAlwaysOpened && this.group.querySelector(".hs-accordion.active") && this.group.querySelector(".hs-accordion.active") !== this.el) {
          const currentlyOpened = window.$hsAccordionCollection.find(
            (el) => el.element.el === this.group.querySelector(".hs-accordion.active")
          );
          currentlyOpened.element.hide();
        }
        if (this.el.classList.contains("active"))
          return false;
        this.el.classList.add("active");
        this.content.style.display = "block";
        this.content.style.height = "0";
        setTimeout(() => {
          this.content.style.height = `${this.content.scrollHeight}px`;
        });
        afterTransition(this.content, () => {
          this.content.style.display = "block";
          this.content.style.height = "";
          this.fireEvent("open", this.el);
          dispatch("open.hs.accordion", this.el, this.el);
        });
      }
      hide() {
        if (!this.el.classList.contains("active"))
          return false;
        this.el.classList.remove("active");
        this.content.style.height = `${this.content.scrollHeight}px`;
        setTimeout(() => {
          this.content.style.height = "0";
        });
        afterTransition(this.content, () => {
          this.content.style.display = "";
          this.content.style.height = "0";
          this.fireEvent("close", this.el);
          dispatch("close.hs.accordion", this.el, this.el);
        });
      }
      // Static methods
      static getInstance(target, isInstance) {
        const elInCollection = window.$hsAccordionCollection.find(
          (el) => el.element.el === (typeof target === "string" ? document.querySelector(target) : target)
        );
        return elInCollection ? isInstance ? elInCollection : elInCollection.element.el : null;
      }
      static show(target) {
        const elInCollection = window.$hsAccordionCollection.find(
          (el) => el.element.el === (typeof target === "string" ? document.querySelector(target) : target)
        );
        if (elInCollection && elInCollection.element.content.style.display !== "block")
          elInCollection.element.show();
      }
      static hide(target) {
        const elInCollection = window.$hsAccordionCollection.find(
          (el) => el.element.el === (typeof target === "string" ? document.querySelector(target) : target)
        );
        if (elInCollection && elInCollection.element.content.style.display === "block")
          elInCollection.element.hide();
      }
      static autoInit() {
        if (!window.$hsAccordionCollection)
          window.$hsAccordionCollection = [];
        document.querySelectorAll(".hs-accordion:not(.--prevent-on-load-init)").forEach((el) => {
          if (!window.$hsAccordionCollection.find(
            (elC) => elC?.element?.el === el
          ))
            new HSAccordion(el);
        });
      }
      // Backward compatibility
      static on(evt, target, cb) {
        const elInCollection = window.$hsAccordionCollection.find(
          (el) => el.element.el === (typeof target === "string" ? document.querySelector(target) : target)
        );
        if (elInCollection)
          elInCollection.element.events[evt] = cb;
      }
    };
    window.addEventListener("load", () => {
      HSAccordion.autoInit();
    });
    if (typeof window !== "undefined") {
      window.HSAccordion = HSAccordion;
    }
    accordion_default = HSAccordion;
  }
});

// src/accordion.ts
var AccordionHook = {
  mounted() {
    Promise.resolve().then(() => (init_accordion(), accordion_exports)).then((module) => {
      module?.default?.autoInit();
    });
  },
  updated() {
    Promise.resolve().then(() => (init_accordion(), accordion_exports)).then((module) => {
      module?.default?.autoInit();
    });
  }
};

// src/themeSwitcher.ts
var ThemeSwitcherHook = {
  mounted() {
    this.el.addEventListener("click", () => {
      const theme = localStorage.getItem("theme") ?? "light";
      const newTheme = theme === "dark" ? "light" : "dark";
      document.documentElement.classList.toggle("dark", newTheme === "dark");
      localStorage.setItem("theme", newTheme);
    });
  }
};

// src/hooks.ts
var hooks = {
  ThemeSwitcher: ThemeSwitcherHook,
  Accordion: AccordionHook
};

// app.ts
var dom = {
  onBeforeElUpdated(fromEl, toEl) {
    if (fromEl.classList.contains("hs-accordion")) {
      toEl.className = fromEl.className;
    }
  }
};
export {
  dom,
  hooks
};
/*! Bundled license information:

preline/src/plugins/base-plugin/index.ts:
  (*
   * HSBasePlugin
   * @version: 2.1.0
   * @author: HTMLStream
   * @license: Licensed under MIT (https://preline.co/docs/license.html)
   * Copyright 2023 HTMLStream
   *)

preline/src/plugins/accordion/index.ts:
  (*
   * HSAccordion
   * @version: 2.1.0
   * @author: HTMLStream
   * @license: Licensed under MIT (https://preline.co/docs/license.html)
   * Copyright 2023 HTMLStream
   *)
*/
//# sourceMappingURL=live_view_ui.mjs.map
