<script lang="ts">
  import type { InertiaForm } from '@inertiajs/svelte'
  import { Link } from '@inertiajs/svelte'

  import Button from '$lib/components/ui/button/button.svelte'
  import type { ItemForm } from '$types/formTypes'
  import type { Item } from '$types/typelizer'

  import Form from './Form.svelte'

  let { item }: { item: Item } = $props()

  const handleSubmit = (form: InertiaForm<ItemForm>) => {
    form.transform((data) => ({ item: data }))
    form.patch(`/items/${item.id}`)
  }
</script>

<svelte:head>
  <title>Edit Barang</title>
</svelte:head>

<div class="mx-auto max-w-screen-sm p-8">
  <h1 class="text-4xl font-bold">Edit Barang</h1>
  <Form {item} submitText="Update Barang" onsubmit={handleSubmit} />
  <Link href={`/items/${item.id}`}
    ><Button variant="secondary">Lihat Barang</Button></Link
  >
</div>
