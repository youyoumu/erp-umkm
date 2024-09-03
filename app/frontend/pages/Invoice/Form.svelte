<script>
import { useForm } from "@inertiajs/svelte"
import { createEventDispatcher } from "svelte"
import Select from "svelte-select/Select.svelte"
import { Input } from "$lib/components/ui/input"
import Label from "$lib/components/ui/label/label.svelte"
import Button from "$lib/components/ui/button/button.svelte"

import CalendarIcon from "lucide-svelte/icons/calendar"
import { DateFormatter, getLocalTimeZone } from "@internationalized/date"
import { cn } from "$lib/utils.js"
import { Calendar } from "$lib/components/ui/calendar"
import * as Popover from "$lib/components/ui/popover"

const df = new DateFormatter("en-US", {
  dateStyle: "long",
})

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

<form class="flex flex-col gap-4 py-4" on:submit|preventDefault={dispatch('submit', { form: $form })}>
  <div class="flex justify-end">
    <Popover.Root openFocus>
      <Popover.Trigger asChild let:builder>
        <Button
          variant="outline"
          class={cn(
            "w-[280px] justify-start text-left font-normal",
            !$form.date && "text-muted-foreground"
          )}
          builders={[builder]}
        >
          <CalendarIcon class="mr-2 h-4 w-4" />
          {$form.date ? df.format($form.date.toDate(getLocalTimeZone())) : "Select a date"}
        </Button>
      </Popover.Trigger>
      <Popover.Content class="w-auto p-0">
        <Calendar bind:value={$form.date} initialFocus />
      </Popover.Content>
    </Popover.Root>
  </div>

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

  <div class="text-xs">{JSON.stringify($form.items)}</div>
  <div class="text-xs">{JSON.stringify($form.date)}</div>
</form>

<style>
:global(.svelte-select) {
  border: 1px solid #7c7c7c !important;
}
</style>
