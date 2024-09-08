<script>
import { ExternalLink } from "lucide-svelte"
export let customer
</script>

{#if customer}
  <a href="/customers/{customer.id}" class="flex size-full items-center gap-2" target="_blank">
    <div>{customer.name}</div>
    <ExternalLink opacity="0.25" size="20" />
  </a>
{:else}
  <div></div>
{/if}
