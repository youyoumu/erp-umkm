<script>
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
  <title>Editing item</title>
</svelte:head>

<div class="mx-auto md:w-2/3 w-full px-8 pt-8">
  <h1 class="font-bold text-4xl">Editing item</h1>

  <Form
    {item}
    submitText="Update item"
    on:submit={handleSubmit}
  />

  <Link
    href={`/items/${item.id}`}
    class="mt-2 rounded-lg py-3 px-5 bg-gray-100 inline-block font-medium"
  >
    Show this item
  </Link>
  <Link
    href="/items"
    class="ml-2 rounded-lg py-3 px-5 bg-gray-100 inline-block font-medium"
  >
    Back to items
  </Link>
</div>
