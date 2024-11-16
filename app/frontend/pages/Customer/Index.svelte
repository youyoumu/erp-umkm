<script lang="ts">
  // export { default as layout } from '../../lib/components/LayoutNav.svelte'
  import Button from '$lib/components/ui/button/button.svelte'
  import { Link, inertia } from '@inertiajs/svelte'
  let { customers, flash } = $props()

  const onDestroy = (e) => {
    if (!confirm('Are you sure you want to delete this customer?')) {
      e.preventDefault()
    }
  }
</script>

<svelte:head>
  <title>Customers</title>
</svelte:head>

<div class="w-full p-8">
  {#if flash.notice}
    <p
      class="mb-5 inline-block rounded-lg bg-green-50 px-3 py-2 font-medium text-green-500"
    >
      {flash.notice}
    </p>
  {/if}

  <div class="mb-8 flex items-center justify-between">
    <h1 class="text-4xl font-bold">Daftar Pembeli</h1>
    <a href="/customers/new" use:inertia><Button>Pembeli Baru</Button></a>
  </div>

  <div class="min-w-full">
    {#each customers as customer (customer.id)}
      <p>
        <Link
          href={`/customers/${customer.id}`}
          class="text-blue-600 underline"
        >
          {customer.name}
        </Link>
      </p>
    {/each}
  </div>
</div>
