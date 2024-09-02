<script context="module">
export { default as layout } from "../LayoutNav.svelte"
</script>

<script>
import { Link, inertia } from "@inertiajs/svelte"

export let items
export let flash

const onDestroy = (e) => {
  if (!confirm("Are you sure you want to delete this item?")) {
    e.preventDefault()
  }
}
</script>

<svelte:head>
  <title>Items</title>
</svelte:head>

<div class="w-full p-8">
  {#if flash.notice}
    <p class="mb-5 inline-block rounded-lg bg-green-50 px-3 py-2 font-medium text-green-500">
      {flash.notice}
    </p>
  {/if}

  <div class="mb-8 flex items-center justify-between">
    <h1 class="text-4xl font-bold">Daftar Barang</h1>
    <Link href="/items/new" class="block rounded-lg bg-blue-600 px-5 py-3 font-medium text-white">Barang Baru</Link>
  </div>

  <div class="min-w-full">
    {#each items as item (item.id)}
      <div class="flex justify-between">
        <a href={`/items/${item.id}`} class="text-blue-500 underline" use:inertia>{item.name}</a>
      </div>
    {/each}
  </div>
</div>
