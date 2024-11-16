<script lang="ts">
  // export { default as layout } from '../../lib/components/LayoutNav.svelte'
  import Form from './Form.svelte'
  let { item } = $props()

  const handleSubmit = (e) => {
    const { form } = e.detail
    form.transform((data) => ({ item: data }))
    form.post('/items')
  }
</script>

<svelte:head>
  <title>Barang Baru</title>
</svelte:head>

<div class="mx-auto max-w-screen-sm p-8">
  <h1 class="text-4xl font-bold">Barang Baru</h1>
  <Form {item} submitText="Tambah Barang" on:submit={handleSubmit} />
</div>
