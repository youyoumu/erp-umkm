<script lang="ts">
  import { ExternalLink } from 'lucide-svelte'
  let { customer } = $props()
</script>

<a
  href="/customers/{customer.id}"
  class="flex size-full items-center gap-2"
  target="_blank"
>
  <div class="truncate">{customer.name}</div>
  <ExternalLink opacity="0.25" size="20" />
</a>
