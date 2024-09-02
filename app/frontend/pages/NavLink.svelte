<script>
import { inertia } from "@inertiajs/svelte"
import { cn } from "$lib/utils"

export let href = ""
export let active = false

$: linkClass = cn("rounded-sm px-5 py-2 transition-colors hover:bg-slate-800", {
  underline: active,
})
</script>

<a class={linkClass} href={href} use:inertia>
  <slot />
</a>
