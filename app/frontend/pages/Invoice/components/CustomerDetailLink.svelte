<script lang="ts">
  import { ExternalLink } from 'lucide-svelte'
  let { customer } = $props()
</script>

{#if customer}
  <a
    href="/customers/{customer.id}"
    class="flex size-full items-center gap-2"
    target="_blank"
  >
    <div class="truncate">{customer.name}</div>
    <ExternalLink opacity="0.25" size="20" class="min-w-[20px]" />
  </a>
{:else}
  <div></div>
{/if}
