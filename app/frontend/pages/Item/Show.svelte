<script context="module">
export { default as layout } from "../LayoutNav.svelte"
</script>

<script>
import * as AlertDialog from "$lib/components/ui/alert-dialog"
import { inertia, router } from "@inertiajs/svelte"
import ItemDetail from "./components/ItemDetail.svelte"
import Button from "$lib/components/ui/button/button.svelte"

export let item
export let flash
console.log(item)

const onDestroy = (e) => {
  router.delete(`/items/${item.id}`)
}
</script>

<svelte:head>
  <title>Barang #{item.id}</title>
</svelte:head>

<div class="mx-auto max-w-screen-sm p-8">
  <div class="mx-auto">
    {#if flash.notice}
      <p class="mb-5 inline-block rounded-lg bg-green-50 px-3 py-2 font-medium text-green-500">
        {flash.notice}
      </p>
    {/if}

    <h1 class="mb-4 text-4xl font-bold">Barang #{item.id}</h1>

    <div class="flex flex-col gap-1">
      <ItemDetail label="Nama" value={item.name} />
      <ItemDetail label="Harga Modal" value={item.cost_price} />
      <ItemDetail label="Harga Jual" value={item.selling_price} />
      <ItemDetail label="Stok" value={item.stock} />
      <ItemDetail label="Kode Barang" value={item.code} />
      <ItemDetail label="Kategori" value={item.category} />
      <ItemDetail label="Tag" value={item.tag} />
    </div>
    <div class="my-4">
      <div class="mb-2 font-bold">Catatan:</div>
      <div class="min-h-32 rounded-sm border border-slate-300 p-2">{item.notes}</div>
    </div>

    <div class="flex gap-2">
      <Button href={`/items/${item.id}/edit`} variant="secondary">Edit</Button>
      <AlertDialog.Root>
        <AlertDialog.Trigger><Button variant="destructive">Hapus</Button></AlertDialog.Trigger>
        <AlertDialog.Content>
          <AlertDialog.Header>
            <AlertDialog.Title>Apakah kamu yakin ingin menghapus barang ini?</AlertDialog.Title>
            <AlertDialog.Description>
              <!-- This action cannot be undone. This will permanently delete your account and remove your data from our servers. -->
            </AlertDialog.Description>
          </AlertDialog.Header>
          <AlertDialog.Footer>
            <AlertDialog.Cancel>Batal</AlertDialog.Cancel>
            <AlertDialog.Action on:click={onDestroy} class="bg-red-600 hover:bg-red-700">Hapus</AlertDialog.Action>
          </AlertDialog.Footer>
        </AlertDialog.Content>
      </AlertDialog.Root>
    </div>
  </div>
</div>
