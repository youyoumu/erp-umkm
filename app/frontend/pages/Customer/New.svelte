<script context="module">
export { default as layout } from "../LayoutNav.svelte"
</script>

<script>
import Form from "./Form.svelte"
export let customer

const handleSubmit = (e) => {
  const { form } = e.detail
  form.transform((data) => ({ customer: data }))
  form.post("/customers")
}
</script>

<svelte:head>
  <title>Pembeli Baru</title>
</svelte:head>

<div class="mx-auto max-w-screen-sm p-8">
  <h1 class="text-4xl font-bold">Pembeli Baru</h1>
  <Form customer={customer} submitText="Tambah Pembeli" on:submit={handleSubmit} />
</div>
