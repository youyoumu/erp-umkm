<script>
  import { Link } from '@inertiajs/svelte'
  import Form from './Form.svelte'

  export let customer

  const handleSubmit = (e) => {
    const { form } = e.detail
    form.transform((data) => ({ customer: data }))
    form.patch(`/customers/${customer.id}`)
  }
</script>

<svelte:head>
  <title>Editing customer</title>
</svelte:head>

<div class="mx-auto md:w-2/3 w-full px-8 pt-8">
  <h1 class="font-bold text-4xl">Editing customer</h1>

  <Form
    {customer}
    submitText="Update customer"
    on:submit={handleSubmit}
  />

  <Link
    href={`/customers/${customer.id}`}
    class="mt-2 rounded-lg py-3 px-5 bg-gray-100 inline-block font-medium"
  >
    Show this customer
  </Link>
  <Link
    href="/customers"
    class="ml-2 rounded-lg py-3 px-5 bg-gray-100 inline-block font-medium"
  >
    Back to customers
  </Link>
</div>
