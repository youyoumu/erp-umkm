<script>
  import { Link } from '@inertiajs/svelte'
  import Item from './Item.svelte'

  export let items
  export let flash

  const onDestroy = (e) => {
    if (!confirm('Are you sure you want to delete this item?')) {
      e.preventDefault()
    }
  }
</script>

<svelte:head>
  <title>Items</title>
</svelte:head>

<div class="mx-auto md:w-2/3 w-full px-8 pt-8">
  {#if flash.notice}
    <p class="py-2 px-3 bg-green-50 mb-5 text-green-500 font-medium rounded-lg inline-block">
      {flash.notice}
    </p>
  {/if}

  <div class="flex justify-between items-center">
    <h1 class="font-bold text-4xl">Items</h1>
    <Link
      href="/items/new"
      class="rounded-lg py-3 px-5 bg-blue-600 text-white block font-medium"
    >
      New item
    </Link>
  </div>

  <div class="min-w-full">
    {#each items as item (item.id)}
      <Item {item} />
      <p>
        <Link
          href={`/items/${item.id}`}
          class="ml-2 rounded-lg py-3 px-5 bg-gray-100 inline-block font-medium"
        >
          Show this item
        </Link>
      </p>
    {/each}
  </div>
</div>
