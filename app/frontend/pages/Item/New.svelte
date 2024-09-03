<script context="module">
export { default as layout } from "../LayoutNav.svelte"
</script>

<script>
import Form from "./Form.svelte"
export let item

const handleSubmit = (e) => {
  const { form } = e.detail
  form.transform((data) => ({ item: data }))
  form.post("/items")
}
</script>

<svelte:head>
  <title>Barang Baru</title>
</svelte:head>

<div class="mx-auto max-w-screen-sm p-8">
  <h1 class="text-4xl font-bold">Barang Baru</h1>
  <Form item={item} submitText="Tambah Barang" on:submit={handleSubmit} />
</div>
