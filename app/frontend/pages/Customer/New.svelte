<script lang="ts">
  import type { CustomerForm } from '$types/formTypes'
  import type { Customer } from '$types/typelizer'
  import type { InertiaForm } from '@inertiajs/svelte'
  import Form from './Form.svelte'

  let { customer }: { customer: Customer } = $props()

  const handleSubmit = (form: InertiaForm<CustomerForm>) => {
    form.transform((data) => ({ customer: data }))
    form.post('/customers')
  }
</script>

<svelte:head>
  <title>Pembeli Baru</title>
</svelte:head>

<div class="mx-auto max-w-screen-sm p-8">
  <h1 class="text-4xl font-bold">Pembeli Baru</h1>
  <Form {customer} submitText="Tambah Pembeli" onsubmit={handleSubmit} />
</div>
