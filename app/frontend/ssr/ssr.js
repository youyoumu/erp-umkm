import LayoutNav from '$lib/components/LayoutNav.svelte'
import { createInertiaApp } from '@inertiajs/svelte'
import createServer from '@inertiajs/svelte/server'
import { render } from 'svelte/server'

createServer((page) =>
  createInertiaApp({
    page,
    resolve: (name) => {
      const pages = import.meta.glob('../pages/**/*.svelte', { eager: true })
      const page = pages[`../pages/${name}.svelte`]
      // @ts-ignore
      return { default: page.default, layout: page.layout || LayoutNav }
    },
    setup({ App, props }) {
      return render(App, { props })
    },
  })
)
