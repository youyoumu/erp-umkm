<script lang="ts">
  // export { default as layout } from '../../lib/components/LayoutNav.svelte'
  import Form from './Form.svelte'

  let { invoice, items, customers } = $props()

  const handleSubmit = (e) => {
    const { form } = e.detail
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
    {items}
    {invoice}
    {customers}
    submitText="Buat Nota"
    on:submit={handleSubmit}
  />
</div>
