<script lang="ts">
  import { ExternalLink } from 'lucide-svelte'
  let { invoice } = $props()
</script>

<a
  href="/invoices/{invoice.id}"
  class="flex size-full items-center gap-2"
  target="_blank"
>
  <div class="truncate">{invoice.code}</div>
  <ExternalLink opacity="0.25" size="20" />
</a>
