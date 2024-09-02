<script>
import { Link } from "@inertiajs/svelte"
import Form from "./Form.svelte"

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

<div class="mx-auto w-full px-8 pt-8 md:w-2/3">
  <h1 class="text-4xl font-bold">Editing customer</h1>

  <Form
    customer={customer}
    submitText="Update customer"
    on:submit={handleSubmit}
  />

  <Link
    href={`/customers/${customer.id}`}
    class="mt-2 inline-block rounded-lg bg-gray-100 px-5 py-3 font-medium"
  >
    Show this customer
  </Link>
  <Link
    href="/customers"
    class="ml-2 inline-block rounded-lg bg-gray-100 px-5 py-3 font-medium"
  >
    Back to customers
  </Link>
</div>
