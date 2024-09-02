<script>
import { inertia, Link } from "@inertiajs/svelte"
import Item from "./Item.svelte"

export let item
export let flash

const onDestroy = (e) => {
  if (!confirm("Are you sure you want to delete this item?")) {
    e.preventDefault()
  }
}
</script>

<svelte:head>
  <title>Item #{item.id}</title>
</svelte:head>

<div class="mx-auto w-full px-8 pt-8 md:w-2/3">
  <div class="mx-auto">
    {#if flash.notice}
      <p
        class="mb-5 inline-block rounded-lg bg-green-50 px-3 py-2 font-medium text-green-500"
      >
        {flash.notice}
      </p>
    {/if}

    <h1 class="text-4xl font-bold">Item #{item.id}</h1>

    <Item item={item} />

    <Link
      href={`/items/${item.id}/edit`}
      class="ml-2 inline-block rounded-lg bg-gray-100 px-5 py-3 font-medium"
    >
      Edit this item
    </Link>
    <Link
      href="/items"
      class="ml-2 inline-block rounded-lg bg-gray-100 px-5 py-3 font-medium"
    >
      Back to items
    </Link>
    <div class="ml-2 inline-block">
      <button
        use:inertia={{ href: `/items/${item.id}`, method: 'delete' }}
        on:click={onDestroy}
        type="button"
        class="mt-2 rounded-lg bg-gray-100 px-5 py-3 font-medium"
      >
        Destroy this item
      </button>
    </div>
  </div>
</div>
