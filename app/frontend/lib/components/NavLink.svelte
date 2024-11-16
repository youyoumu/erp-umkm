<script lang="ts">
  import { Link } from '@inertiajs/svelte'
  import type { Snippet } from 'svelte'
  import { Button } from './ui/button'

  let {
    href = '',
    active,
    children,
  }: { href: string; active: boolean; children?: Snippet } = $props()

  // $: linkClass = cn("rounded-sm px-5 py-2 transition-colors hover:bg-slate-800", {
  //   underline: active,
  // })
</script>

<Link {href}>
  {@render children?.()}
</Link>
