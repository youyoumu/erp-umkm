<script>
import Invoice from "./Invoice.svelte"

export let invoice
export let items
</script>

<main class="flex h-svh min-h-svh flex-col p-4">
  <Invoice invoice={invoice} items={items} />
</main>
