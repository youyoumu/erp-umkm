<script lang="ts">
  import type { InertiaForm } from '@inertiajs/svelte'
  import { useForm } from '@inertiajs/svelte'
  import { page } from '@inertiajs/svelte'
  import {
    DateFormatter,
    getLocalTimeZone,
    parseDate,
    today,
  } from '@internationalized/date'
  import { X } from 'lucide-svelte'
  import CalendarIcon from 'lucide-svelte/icons/calendar'
  import { nanoid } from 'nanoid'
  import Select from 'svelte-select'

  import * as AlertDialog from '$lib/components/ui/alert-dialog'
  import Button from '$lib/components/ui/button/button.svelte'
  import { Calendar } from '$lib/components/ui/calendar/index.js'
  import { Input } from '$lib/components/ui/input'
  import Label from '$lib/components/ui/label/label.svelte'
  import * as Popover from '$lib/components/ui/popover/index.js'
  import Textarea from '$lib/components/ui/textarea/textarea.svelte'
  import { cn } from '$lib/utils.js'
  import { formatIDR } from '$lib/utils.js'
  import type { InvoiceForm } from '$types/formTypes'
  import type { Customer, Invoice, Item } from '$types/typelizer'

  const df = new DateFormatter('id-ID', {
    dateStyle: 'long',
  })
  let formRef = $state<HTMLFormElement>()

  let {
    invoice,
    submitText,
    items,
    customers,
    onsubmit,
  }: {
    invoice: Invoice
    submitText: string
    items: Item[]
    customers: Customer[]
    onsubmit: (form: InertiaForm<InvoiceForm>) => void
  } = $props()

  const itemsWithTag = items.map((item) => {
    const tag = item.tag ? `#${item.tag}` : ''
    return { ...item, name: `${item.name} ${tag}` }
  })

  const form = useForm<InvoiceForm>({
    date: invoice.date
      ? parseDate(invoice.date).toString()
      : today(getLocalTimeZone()).toString(),
    code: invoice.code || '',
    address: invoice.address || '',
    customer: invoice.customer || {
      id: 0,
    },
    items: invoice.items.map((item) => {
      return { ...item, key: nanoid() }
    }),
  })

  let grandTotal = $derived(
    $form.items.reduce(
      (total, item) => total + item.selling_price * item.quantity,
      0
    )
  )

  function addItem() {
    $form.items = [
      ...$form.items,
      {
        id: 0,
        quantity: 0,
        quantity_unit: '',
        selling_price: 0,
        key: nanoid(),
      },
    ]
  }

  function updateAddress(text: string) {
    $form.address = text
  }

  if ($page.url === '/invoices/new') {
    addItem()
  }

  $inspect($form.items)
</script>

<form
  bind:this={formRef}
  class="flex flex-col gap-4 py-4"
  onsubmit={(e) => {
    e.preventDefault()
    onsubmit($form)
  }}
>
  <div class="flex justify-between gap-4">
    <div class="flex w-96 flex-col items-center gap-2">
      <div class="items-tart flex w-full flex-col justify-between gap-2">
        <Label for="address">Tanggal</Label>
        <Popover.Root>
          <Popover.Trigger>
            {#snippet child({ props })}
              <Button
                variant="outline"
                class={cn(
                  'w-full justify-start text-left font-normal',
                  !$form.date && 'text-muted-foreground'
                )}
                {...props}
              >
                <CalendarIcon class="mr-2 size-4" />
                {df.format(parseDate($form.date).toDate(getLocalTimeZone()))}
              </Button>
            {/snippet}
          </Popover.Trigger>
          <Popover.Content class="w-auto p-0">
            <Calendar
              value={parseDate($form.date)}
              onValueChange={(v) => {
                $form.date = v!.toString()
              }}
              type="single"
              initialFocus
            />
          </Popover.Content>
        </Popover.Root>
      </div>
      <div class="flex w-full flex-col items-start justify-between gap-2">
        <Label for="code">Kode Nota</Label>
        <Input id="code" bind:value={$form.code} placeholder="Kode Nota" />
      </div>
      <div class="flex w-full flex-col items-start justify-between gap-2">
        <Label for="customer">Pelanggan</Label>
        <Select
          items={customers}
          label="name"
          itemId="id"
          class="svelte-select"
          value={$form.customer.id ? $form.customer : null}
          on:change={(e) => {
            $form.customer = e.detail
            updateAddress(e.detail.address)
          }}
          placeholder="Pilih Pelanggan"
          --font-size="14px"
          --border="1px solid rgb(226, 232, 240)"
        >
          <X slot="clear-icon" class="cursor-pointer" />
        </Select>
      </div>
    </div>

    <div class="flex grow flex-col items-center gap-2">
      <Label for="address">Alamat</Label>
      <Textarea
        id="address"
        bind:value={$form.address}
        placeholder="Masukkan Alamat"
        class="h-full"
      />
    </div>
  </div>

  <div class="flex flex-col gap-2 py-4">
    {#each $form.items as item, i (item.key)}
      {#if $form.items[i]}
        <div class="flex gap-2">
          <div class="flex grow flex-col items-center justify-center gap-2">
            {#if i === 0}
              <Label for="item">Nama Barang</Label>
            {/if}
            <div class="w-full relative">
              <Select
                items={itemsWithTag}
                label="name"
                itemId="id"
                on:change={(e) => {
                  e.detail.key = item.key
                  $form.items[i] = e.detail
                }}
                class={'svelte-select '}
                value={$form.items[i].id ? $form.items[i] : null}
                clearable={false}
                placeholder="Pilih Barang"
                --font-size="14px"
                --border="1px solid rgb(226, 232, 240)"
              />
              <X
                class="cursor-pointer absolute right-2 top-1/2 -translate-y-1/2"
                onclick={() => {
                  $form.items.splice(i, 1)
                  $form.items = $form.items
                }}
              />
            </div>
          </div>

          <div class="flex max-w-32 flex-col items-center justify-center gap-2">
            {#if i === 0}
              <Label for={`quantity-${i}`}>Jumlah Barang</Label>
            {/if}
            <Input
              type="number"
              id={`quantity-${i}`}
              bind:value={$form.items[i].quantity}
              min="0"
              onfocus={(e) => {
                e.currentTarget.select()
              }}
            />
          </div>
          <div class="flex max-w-32 flex-col items-center justify-center gap-2">
            {#if i === 0}
              <Label for={`quantity-unit-${i}`}>Satuan</Label>
            {/if}
            <Input
              id={`quantity-unit-${i}`}
              bind:value={$form.items[i].quantity_unit}
            />
          </div>
          <div class="flex max-w-32 flex-col items-center justify-center gap-2">
            {#if i === 0}
              <Label>Harga Satuan</Label>
            {/if}
            <Input bind:value={$form.items[i].selling_price} />
          </div>
          <div class="flex max-w-32 flex-col items-center justify-center gap-2">
            {#if i === 0}
              <Label>Total</Label>
            {/if}
            <Input
              value={formatIDR(
                $form.items[i].quantity * $form.items[i].selling_price
              )}
              disabled
              class="disabled:opacity-100"
            />
          </div>
        </div>
      {/if}
    {/each}
  </div>

  <div class="flex justify-end font-bold">
    <div>Total: {formatIDR(grandTotal)}</div>
  </div>

  <div class="flex justify-end gap-4">
    <Button variant="secondary" onclick={addItem}>Tambah Barang</Button>

    <AlertDialog.Root>
      <AlertDialog.Trigger><Button>{submitText}</Button></AlertDialog.Trigger>
      <AlertDialog.Content>
        <AlertDialog.Header>
          <AlertDialog.Title
            >Apakah kamu yakin ingin membuat nota ini?</AlertDialog.Title
          >
          <AlertDialog.Description>
            <!-- This action cannot be undone. This will permanently delete your account
            and remove your data from our servers. -->
          </AlertDialog.Description>
        </AlertDialog.Header>
        <AlertDialog.Footer>
          <AlertDialog.Cancel>Batal</AlertDialog.Cancel>
          <AlertDialog.Action
            ><button
              disabled={$form.processing}
              onclick={() => formRef?.requestSubmit()}
            >
              {submitText}
            </button></AlertDialog.Action
          >
        </AlertDialog.Footer>
      </AlertDialog.Content>
    </AlertDialog.Root>
  </div>
</form>
