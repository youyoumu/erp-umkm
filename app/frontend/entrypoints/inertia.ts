import LayoutNav from '$lib/components/LayoutNav.svelte'
import { createInertiaApp, type ResolvedComponent } from '@inertiajs/svelte'
import { hydrate, mount } from 'svelte'

createInertiaApp({
  // Set default page title
  // see https://inertia-rails.netlify.app/guide/title-and-meta
  //
  // title: title => title ? `${title} - App` : 'App',

  // Disable progress bar
  //
  // see https://inertia-rails.netlify.app/guide/progress-indicators
  // progress: false,

  // @ts-ignore https://github.com/inertiajs/inertia/issues/1770
  resolve: (name) => {
    const pages = import.meta.glob<ResolvedComponent>('../pages/**/*.svelte', {
      eager: true,
    })
    const page = pages[`../pages/${name}.svelte`]
    return {
      default: page.default,
      layout: name === 'Invoice/Print' ? undefined : page.layout || LayoutNav,
    }

    // To use a default layout, import the Layout component
    // and use the following lines.
    // see https://inertia-rails.netlify.app/guide/pages#default-layouts
    //
    // const page = pages[`../pages/${name}.svelte`]
    // return { default: page.default, layout: page.layout || Layout }
  },

  setup({ el, App, props }) {
    if (el!.dataset.serverRendered === 'true') {
      hydrate(App, { target: el!, props })
    } else {
      mount(App, { target: el!, props })
    }
  },
})
