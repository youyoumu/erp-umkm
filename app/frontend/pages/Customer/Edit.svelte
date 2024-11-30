<script lang="ts">
  import type { InertiaForm } from '@inertiajs/svelte'
  import { Link } from '@inertiajs/svelte'

  import Button from '$lib/components/ui/button/button.svelte'
  import type { CustomerForm } from '$types/formTypes'
  import type { Customer } from '$types/typelizer'

  import Form from './Form.svelte'

  let {
    customer,
  }: {
    customer: Customer
  } = $props()

  const handleSubmit = (form: InertiaForm<CustomerForm>) => {
    form.transform((data) => ({ customer: data }))
    form.patch(`/customers/${customer.id}`)
  }
</script>

<svelte:head>
  <title>Edit Pembeli</title>
</svelte:head>

<div class="mx-auto max-w-screen-sm p-8">
  <h1 class="text-4xl font-bold">Edit Pembeli</h1>

  <Form {customer} submitText="Update Pembeli" onsubmit={handleSubmit} />

  <Link href={`/customers/${customer.id}`}
    ><Button variant="secondary">Lihat Pembeli</Button></Link
  >
</div>
