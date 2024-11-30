<script lang="ts">
  import { Link } from '@inertiajs/svelte'
  import type { Snippet } from 'svelte'

  import { cn } from '$lib/utils'

  let {
    href = '',
    active,
    children,
  }: { href: string; active: boolean; children?: Snippet } = $props()

  const linkClass = $derived(
    cn('rounded-sm px-5 py-2 transition-colors hover:bg-secondary/10', {
      underline: active,
    })
  )
</script>

<Link class={linkClass} {href}>
  {@render children?.()}
</Link>
