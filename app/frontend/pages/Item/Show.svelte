<script lang="ts">
  import { inertia, router } from '@inertiajs/svelte'

  import * as AlertDialog from '$lib/components/ui/alert-dialog'
  import Button from '$lib/components/ui/button/button.svelte'
  import type { Item } from '$types/typelizer'

  import ItemDetail from './components/ItemDetail.svelte'

  let {
    item,
    flash,
    sold_snapshots_grouped_by_quantity_unit,
  }: {
    item: Item
    flash: any
    sold_snapshots_grouped_by_quantity_unit: Record<string, Item[]>
  } = $props()

  const onDestroy = () => {
    router.delete(`/items/${item.id}`)
  }
</script>

<svelte:head>
  <title>Barang #{item.id}</title>
</svelte:head>

{#snippet soldPerQuantityUnit(quantity_unit: string, items: Item[])}
  <div>
    {items.reduce((total, item) => total + item.quantity, 0)}
    {quantity_unit}
  </div>
{/snippet}

<div class="mx-auto max-w-screen-sm p-8">
  <div class="mx-auto">
    {#if flash.notice}
      <p
        class="mb-5 inline-block rounded-lg bg-green-50 px-3 py-2 font-medium text-green-500"
      >
        {flash.notice}
      </p>
    {/if}

    <h1 class="mb-4 text-4xl font-bold">Barang #{item.id}</h1>

    <div class="flex flex-col gap-1 pb-4">
      <ItemDetail label="Nama" value={item.name} />
      <ItemDetail label="Harga Modal" value={item.cost_price} />
      <ItemDetail label="Harga Jual" value={item.selling_price} />
      <ItemDetail label="Stok" value={item.stock} />
      <ItemDetail label="Satuan" value={item.quantity_unit} />
      <ItemDetail label="Kode Barang" value={item.code} />
      <ItemDetail label="Kategori" value={item.category} />
      <ItemDetail label="Tag" value={item.tag} />
    </div>
    <div class="pb-4">
      <div class="mb-2 font-bold">Catatan:</div>
      <div class="min-h-32 rounded-sm border border-slate-300 p-2">
        {item.notes}
      </div>
    </div>

    <div class="font-bold">Total Terjual:</div>
    {#each Object.entries(sold_snapshots_grouped_by_quantity_unit) as [quantity_unit, items]}
      {@render soldPerQuantityUnit(quantity_unit, items)}
    {/each}

    <div class="flex gap-2 pt-4">
      <a href={`/items/${item.id}/edit`} use:inertia
        ><Button variant="secondary">Edit</Button></a
      >
      <AlertDialog.Root>
        <AlertDialog.Trigger
          ><Button variant="destructive">Hapus</Button></AlertDialog.Trigger
        >
        <AlertDialog.Content>
          <AlertDialog.Header>
            <AlertDialog.Title
              >Apakah kamu yakin ingin menghapus barang ini?</AlertDialog.Title
            >
            <AlertDialog.Description>
              <!-- This action cannot be undone. This will permanently delete your account and remove your data from our servers. -->
            </AlertDialog.Description>
          </AlertDialog.Header>
          <AlertDialog.Footer>
            <AlertDialog.Cancel>Batal</AlertDialog.Cancel>
            <AlertDialog.Action
              onclick={onDestroy}
              class="bg-red-600 hover:bg-red-700">Hapus</AlertDialog.Action
            >
          </AlertDialog.Footer>
        </AlertDialog.Content>
      </AlertDialog.Root>
    </div>
  </div>
</div>
