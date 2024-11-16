<script>
  // export { default as layout } from '../../lib/components/LayoutNav.svelte'
  import Button from '$lib/components/ui/button/button.svelte'
  import { Link } from '@inertiajs/svelte'
  import Form from './Form.svelte'

  export let item

  const handleSubmit = (e) => {
    const { form } = e.detail
    form.transform((data) => ({ item: data }))
    form.patch(`/items/${item.id}`)
  }
</script>

<svelte:head>
  <title>Edit Barang</title>
</svelte:head>

<div class="mx-auto max-w-screen-sm p-8">
  <h1 class="text-4xl font-bold">Edit Barang</h1>
  <Form {item} submitText="Update Barang" on:submit={handleSubmit} />
  <Link href={`/items/${item.id}`}
    ><Button variant="secondary">Lihat Barang</Button></Link
  >
</div>
