<script>
import { useForm } from "@inertiajs/svelte"
import { createEventDispatcher } from "svelte"
import Select from "svelte-select/Select.svelte"
import { Input } from "$lib/components/ui/input"
import Label from "$lib/components/ui/label/label.svelte"
import Button from "$lib/components/ui/button/button.svelte"

const dispatch = createEventDispatcher()
export let invoice
export let submitText
export let items
const formattedItems = items.map((item) => ({ ...item, label: item.name, value: item.id, quantity: 0 }))

const form = useForm({
  date: invoice.date || "",
  code: invoice.code || "",
  items: invoice.items || [{ ...formattedItems[0], label: "", value: "", id: 0, selling_price: 0 }],
})

function addItem() {
  $form.items = [...$form.items, { ...formattedItems[0], label: "", value: "", id: 0, selling_price: 0 }]
}
</script>

<form class="contents" on:submit|preventDefault={dispatch('submit', { form: $form })}>
  <div class="flex flex-col gap-4 py-4">
    {#each $form.items as item, i (i)}
      {#if $form.items[i]}
        <div class="flex gap-2">
          <Select items={formattedItems} bind:value={$form.items[i]} class="svelte-select" />
          <div class="flex flex-col items-center justify-center gap-2">
            <Label for={`quantity-${i}`}>Jumlah Barang</Label>
            <Input type="number" id={`quantity-${i}`} bind:value={$form.items[i].quantity} min="0" />
          </div>
          <div class="flex flex-col items-center justify-center gap-2">
            <Label for={`quantity-type-${i}`}>Satuan</Label>
            <Input id={`quantity-type-${i}`} bind:value={$form.items[i].quantityType} />
          </div>
          <div class="flex flex-col items-center justify-center gap-2">
            <Label>Harga Satuan</Label>
            <Input value={$form.items[i].selling_price} disabled class="disabled:opacity-100" />
          </div>
          <div class="flex flex-col items-center justify-center gap-2">
            <Label>Total</Label>
            <Input value={$form.items[i].quantity * $form.items[i].selling_price} disabled class="disabled:opacity-100" />
          </div>
        </div>
      {/if}
    {/each}
  </div>

  <Button on:click={addItem}>Tambah Barang</Button>

  <div class="my-5">
    <label for="date">Date</label>
    <input
      type="datetime-local"
      name="date"
      id="date"
      bind:value={$form.date}
      class="mt-2 block w-full rounded-md border border-gray-400 px-3 py-2 shadow outline-none"
    />
    {#if $form.errors.date}
      <div class="px-3 py-2 font-medium text-red-500">
        {$form.errors.date.join(', ')}
      </div>
    {/if}
  </div>

  <div class="my-5">
    <label for="code">Code</label>
    <input
      type="text"
      name="code"
      id="code"
      bind:value={$form.code}
      class="mt-2 block w-full rounded-md border border-gray-400 px-3 py-2 shadow outline-none"
    />
    {#if $form.errors.code}
      <div class="px-3 py-2 font-medium text-red-500">
        {$form.errors.code.join(', ')}
      </div>
    {/if}
  </div>

  <div class="inline">
    <button
      type="submit"
      disabled={$form.processing}
      class="inline-block cursor-pointer rounded-lg bg-blue-600 px-5 py-3 font-medium text-white"
    >
      {submitText}
    </button>
  </div>

  <div class="p-8 text-xs">{JSON.stringify($form.items)}</div>
</form>

<style>
:global(.svelte-select) {
  border: 1px solid #7c7c7c !important;
}
</style>
