<script lang="ts">
  import type { InvoiceForm } from '$types/formTypes'
  import type { Customer, Invoice, Item } from '$types/typelizer'
  import type { InertiaForm } from '@inertiajs/svelte'
  import Form from './Form.svelte'

  let {
    invoice,
    items,
    customers,
  }: {
    invoice: Invoice
    items: Item[]
    customers: Customer[]
  } = $props()

  const handleSubmit = (form: InertiaForm<InvoiceForm>) => {
    form.transform((data) => ({ invoice: data }))
    form.patch(`/invoices/${invoice.id}`)
  }
</script>

<svelte:head>
  <title>Editing invoice</title>
</svelte:head>

<div class="mx-auto p-8">
  <h1 class="text-4xl font-bold mb4">Editing invoice</h1>
  <Form
    {items}
    {invoice}
    {customers}
    submitText="Update Nota"
    onsubmit={handleSubmit}
  />
</div>
