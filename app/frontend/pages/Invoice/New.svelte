<script context="module">
export { default as layout } from "../LayoutNav.svelte"
</script>

<script>
import Form from "./Form.svelte"

export let invoice
export let items
export let customers

const handleSubmit = (e) => {
  const { form } = e.detail
  form.transform((data) => ({ invoice: data }))
  form.post("/invoices")
}
</script>

<svelte:head>
  <title>Nota Baru</title>
</svelte:head>

<div class="mx-auto p-8">
  <h1 class="mb-4 text-4xl font-bold">Nota Baru</h1>
  <Form items={items} invoice={invoice} customers={customers} submitText="Buat Nota" on:submit={handleSubmit} />
</div>
