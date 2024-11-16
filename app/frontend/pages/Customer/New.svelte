<script lang="ts">
  // export { default as layout } from '../../lib/components/LayoutNav.svelte'
  import Form from './Form.svelte'
  let { customer } = $props()

  const handleSubmit = (e) => {
    const { form } = e.detail
    form.transform((data) => ({ customer: data }))
    form.post('/customers')
  }
</script>

<svelte:head>
  <title>Pembeli Baru</title>
</svelte:head>

<div class="mx-auto max-w-screen-sm p-8">
  <h1 class="text-4xl font-bold">Pembeli Baru</h1>
  <Form {customer} submitText="Tambah Pembeli" on:submit={handleSubmit} />
</div>
