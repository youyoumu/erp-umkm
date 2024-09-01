<script>
  import { Link } from '@inertiajs/svelte'
  import Form from './Form.svelte'

  export let invoice

  const handleSubmit = (e) => {
    const { form } = e.detail
    form.transform((data) => ({ invoice: data }))
    form.post('/invoices')
  }
</script>

<svelte:head>
  <title>New invoice</title>
</svelte:head>

<div class="mx-auto md:w-2/3 w-full px-8 pt-8">
  <h1 class="font-bold text-4xl">New invoice</h1>

  <Form
    {invoice}
    submitText="Create invoice"
    on:submit={handleSubmit}
  />

  <Link
    href="/invoices"
    class="ml-2 rounded-lg py-3 px-5 bg-gray-100 inline-block font-medium"
  >
    Back to invoices
  </Link>
</div>
