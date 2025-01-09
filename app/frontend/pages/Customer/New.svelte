<script lang="ts">
  import type { InertiaForm } from '@inertiajs/svelte'

  import type { CustomerForm } from '$types/formTypes'
  import type { Customer } from '$types/typelizer'

  import Form from './Form.svelte'

  let { customer }: { customer: Customer } = $props()

  const handleSubmit = (form: InertiaForm<CustomerForm>) => {
    form.transform((data) => ({ customer: data }))
    form.post('/customers')
  }
</script>

<svelte:head>
  <title>Pelanggan Baru</title>
</svelte:head>

<div class="mx-auto max-w-screen-sm p-8">
  <h1 class="text-4xl font-bold">Pelanggan Baru</h1>
  <Form {customer} submitText="Tambah Pelanggan" onsubmit={handleSubmit} />
</div>
