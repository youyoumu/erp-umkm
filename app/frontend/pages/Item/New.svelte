<script lang="ts">
  import type { ItemForm } from '$types/formTypes'
  import type { Item } from '$types/typelizer'
  import type { InertiaForm } from '@inertiajs/svelte'
  import Form from './Form.svelte'
  let { item }: { item: Item } = $props()

  const handleSubmit = (form: InertiaForm<ItemForm>) => {
    form.transform((data) => ({ item: data }))
    form.post('/items')
  }
</script>

<svelte:head>
  <title>Barang Baru</title>
</svelte:head>

<div class="mx-auto max-w-screen-sm p-8">
  <h1 class="text-4xl font-bold">Barang Baru</h1>
  <Form {item} submitText="Tambah Barang" onsubmit={handleSubmit} />
</div>
