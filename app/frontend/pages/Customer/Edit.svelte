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
  <title>Edit Pelanggan</title>
</svelte:head>

<div class="mx-auto max-w-screen-sm p-8">
  <h1 class="text-4xl font-bold">Edit Pelanggan</h1>

  <Form {customer} submitText="Update Pelanggan" onsubmit={handleSubmit} />

  <Link href={`/customers/${customer.id}`} class="w-full block"
    ><Button variant="secondary" class="w-full">Lihat Pelanggan</Button></Link
  >
</div>
