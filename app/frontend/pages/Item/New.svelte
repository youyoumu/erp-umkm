<script>
  import { Link } from '@inertiajs/svelte'
  import Form from './Form.svelte'

  export let item

  const handleSubmit = (e) => {
    const { form } = e.detail
    form.transform((data) => ({ item: data }))
    form.post('/items')
  }
</script>

<svelte:head>
  <title>New item</title>
</svelte:head>

<div class="mx-auto md:w-2/3 w-full px-8 pt-8">
  <h1 class="font-bold text-4xl">New item</h1>

  <Form
    {item}
    submitText="Create item"
    on:submit={handleSubmit}
  />

  <Link
    href="/items"
    class="ml-2 rounded-lg py-3 px-5 bg-gray-100 inline-block font-medium"
  >
    Back to items
  </Link>
</div>
