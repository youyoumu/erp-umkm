<script lang="ts">
  import { ExternalLink } from 'lucide-svelte'
  let { item } = $props()
</script>

<a
  href="/items/{item.source ? item.source.id : item.id}"
  class="flex size-full items-center gap-2"
  target="_blank"
>
  <div class="truncate">{item.name}</div>
  <ExternalLink opacity="0.25" size="20" />
</a>
