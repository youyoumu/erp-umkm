<script lang="ts">
  import type { InertiaForm } from '@inertiajs/svelte'

  import type { InvoiceForm } from '$types/formTypes'
  import type { Customer, Invoice, Item } from '$types/typelizer'

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
    form.post('/invoices')
  }
</script>

<svelte:head>
  <title>Nota Baru</title>
</svelte:head>

<div class="mx-auto p-8">
  <h1 class="mb-4 text-4xl font-bold">Nota Baru</h1>
  <Form
    {invoice}
    {items}
    {customers}
    submitText="Buat Nota"
    onsubmit={handleSubmit}
  />
</div>
