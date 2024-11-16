<script lang="ts">
  import { Link } from '@inertiajs/svelte'

  export let href = ''
  export let active = false

  // $: linkClass = cn("rounded-sm px-5 py-2 transition-colors hover:bg-slate-800", {
  //   underline: active,
  // })
</script>

<Link {href}>
  <slot />
</Link>
