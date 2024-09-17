<script context="module">
export { default as layout } from "../LayoutNav.svelte"
</script>

<script>
import { Link } from "@inertiajs/svelte"
import Form from "./Form.svelte"
import Button from "$lib/components/ui/button/button.svelte"

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
  <Form item={item} submitText="Update Barang" on:submit={handleSubmit} />
  <Link href={`/items/${item.id}`}><Button variant="secondary">Lihat Barang</Button></Link>
</div>
