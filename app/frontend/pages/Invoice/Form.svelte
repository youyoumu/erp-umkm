<script>
import { useForm } from "@inertiajs/svelte"
import { createEventDispatcher } from "svelte"
import Select from "svelte-select/Select.svelte"
import { Input } from "$lib/components/ui/input"
import Label from "$lib/components/ui/label/label.svelte"
import Button from "$lib/components/ui/button/button.svelte"
import * as AlertDialog from "$lib/components/ui/alert-dialog"
import Textarea from "$lib/components/ui/textarea/textarea.svelte"

import CalendarIcon from "lucide-svelte/icons/calendar"
import { DateFormatter, getLocalTimeZone, now } from "@internationalized/date"
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
export let customers
const formattedItems = items.map((item) => ({ ...item, label: `${item.name} - ${item.tag}`, value: item.id, quantity: 0 }))
const formattedCustomers = customers.map((customer) => ({ ...customer, label: customer.name, value: customer.id }))
const form = useForm({
  date: invoice.date || "",
  code: invoice.code || "",
  address: invoice.address || "",
  customer: invoice.customer || { ...formattedCustomers[0], label: "", value: "", id: 0 },
  items: invoice.items || [{ ...formattedItems[0], label: "", value: "", id: 0, selling_price: 0 }],
})

function addItem() {
  $form.items = [...$form.items, { ...formattedItems[0], label: "", value: "", id: 0, selling_price: 0 }]
}

function handleSelectCustomer(e) {
  const address = e.detail.address
  $form.address = address
}

let value = now()
$: if (value) $form.date = value.toString()
</script>

<form class="flex flex-col gap-4 py-4" on:submit|preventDefault={dispatch('submit', { form: $form })}>
  <div class="flex justify-between gap-4">
    <div class="flex w-96 flex-col items-center gap-2">
      <div class="items-tart flex w-full flex-col justify-between gap-2">
        <Label for="address">Tanggal</Label>
        <Popover.Root openFocus>
          <Popover.Trigger asChild let:builder>
            <Button
              variant="outline"
              class={cn(
                "w-full justify-start text-left font-normal",
                !value && "text-muted-foreground"
              )}
              builders={[builder]}
            >
              <CalendarIcon class="mr-2 h-4 w-4" />
              {value ? df.format(value.toDate(getLocalTimeZone())) : "Select a date"}
            </Button>
          </Popover.Trigger>
          <Popover.Content class="w-auto p-0">
            <Calendar bind:value={value} initialFocus />
          </Popover.Content>
        </Popover.Root>
      </div>
      <div class="flex w-full flex-col items-start justify-between gap-2">
        <Label for="code">Kode Nota</Label>
        <Input id="code" bind:value={$form.code} />
      </div>
      <div class="flex w-full flex-col items-start justify-between gap-2">
        <Label for="customer">Pembeli</Label>
        <Select items={formattedCustomers} bind:value={$form.customer} class="svelte-select" on:select={handleSelectCustomer} />
      </div>
    </div>

    <div class="flex grow flex-col items-center gap-2">
      <Label for="address">Alamat</Label>
      <Textarea id="address" bind:value={$form.address} placeholder="Masukkan Alamat" class="h-full" />
    </div>
  </div>

  <div class="flex flex-col gap-2 py-4">
    {#each $form.items as item, i (i)}
      {#if $form.items[i]}
        <div class="flex gap-2">
          <div class="flex grow flex-col items-center justify-center gap-2">
            {#if i === 0}
              <Label for="item">Nama Barang</Label>
            {/if}
            <Select items={formattedItems} bind:value={$form.items[i]} class="svelte-select" />
          </div>

          <div class="flex max-w-32 flex-col items-center justify-center gap-2">
            {#if i === 0}
              <Label for={`quantity-${i}`}>Jumlah Barang</Label>
            {/if}
            <Input type="number" id={`quantity-${i}`} bind:value={$form.items[i].quantity} min="0" on:focus={(e) => { e.target.select()}} />
          </div>
          <div class="flex max-w-32 flex-col items-center justify-center gap-2">
            {#if i === 0}
              <Label for={`quantity-unit-${i}`}>Satuan</Label>
            {/if}
            <Input id={`quantity-unit-${i}`} bind:value={$form.items[i].quantity_unit} />
          </div>
          <div class="flex max-w-32 flex-col items-center justify-center gap-2">
            {#if i === 0}
              <Label>Harga Satuan</Label>
            {/if}
            <Input value={$form.items[i].selling_price} disabled class="disabled:opacity-100" />
          </div>
          <div class="flex max-w-32 flex-col items-center justify-center gap-2">
            {#if i === 0}
              <Label>Total</Label>
            {/if}
            <Input value={$form.items[i].quantity * $form.items[i].selling_price} disabled class="disabled:opacity-100" />
          </div>
        </div>
      {/if}
    {/each}
  </div>

  <div class="flex justify-end gap-4">
    <Button on:click={addItem} variant="secondary">Tambah Barang</Button>

    <AlertDialog.Root>
      <AlertDialog.Trigger><Button>{submitText}</Button></AlertDialog.Trigger>
      <AlertDialog.Content>
        <AlertDialog.Header>
          <AlertDialog.Title>Apakah kamu yakin ingin membuat nota ini?</AlertDialog.Title>
          <AlertDialog.Description>
            <!-- This action cannot be undone. This will permanently delete your account
            and remove your data from our servers. -->
          </AlertDialog.Description>
        </AlertDialog.Header>
        <AlertDialog.Footer>
          <AlertDialog.Cancel>Batal</AlertDialog.Cancel>
          <AlertDialog.Action
            ><button type="submit" disabled={$form.processing} on:click={dispatch('submit', { form: $form })}>
              {submitText}
            </button></AlertDialog.Action
          >
        </AlertDialog.Footer>
      </AlertDialog.Content>
    </AlertDialog.Root>
  </div>
</form>

<style>
:global(.svelte-select) {
  border: 1px solid rgb(226, 232, 240) !important;
}
</style>
