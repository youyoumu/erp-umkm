<script>
import Invoice from "./Invoice.svelte"

export let invoice
export let items
</script>

<main class="flex h-[528px] w-[816px] flex-col border p-4">
  <Invoice invoice={invoice} items={items} />
</main>
