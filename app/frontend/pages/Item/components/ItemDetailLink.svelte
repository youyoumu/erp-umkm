<script>
import { ExternalLink } from "lucide-svelte"
export let item
</script>

<a href="/items/{item.id}" class="flex size-full items-center gap-2" target="_blank">
  <div>{item.name}</div>
  <ExternalLink opacity="0.25" size="20" />
</a>
