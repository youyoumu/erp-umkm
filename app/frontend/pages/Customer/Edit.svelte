<script context="module">
export { default as layout } from "../LayoutNav.svelte"
</script>

<script>
import { Link } from "@inertiajs/svelte"
import Form from "./Form.svelte"
import Button from "$lib/components/ui/button/button.svelte"

export let customer

const handleSubmit = (e) => {
  const { form } = e.detail
  form.transform((data) => ({ customer: data }))
  form.patch(`/customers/${customer.id}`)
}
</script>

<svelte:head>
  <title>Edit Pembeli</title>
</svelte:head>

<div class="mx-auto max-w-screen-sm p-8">
  <h1 class="text-4xl font-bold">Edit Pembeli</h1>

  <Form customer={customer} submitText="Update Pembeli" on:submit={handleSubmit} />

  <Link href={`/customers/${customer.id}`}><Button variant="secondary">Lihat Pembeli</Button></Link>
</div>
