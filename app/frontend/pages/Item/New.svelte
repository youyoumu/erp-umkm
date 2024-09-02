<script>
import { Link } from "@inertiajs/svelte"
import Form from "./Form.svelte"

export let item

const handleSubmit = (e) => {
  const { form } = e.detail
  form.transform((data) => ({ item: data }))
  form.post("/items")
}
</script>

<svelte:head>
  <title>New item</title>
</svelte:head>

<div class="mx-auto w-full px-8 pt-8 md:w-2/3">
  <h1 class="text-4xl font-bold">New item</h1>

  <Form item={item} submitText="Create item" on:submit={handleSubmit} />

  <Link
    href="/items"
    class="ml-2 inline-block rounded-lg bg-gray-100 px-5 py-3 font-medium"
  >
    Back to items
  </Link>
</div>
