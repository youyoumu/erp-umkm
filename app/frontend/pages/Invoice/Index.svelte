<script>
  import { Link } from '@inertiajs/svelte'
  import Invoice from './Invoice.svelte'

  export let invoices
  export let flash

  const onDestroy = (e) => {
    if (!confirm('Are you sure you want to delete this invoice?')) {
      e.preventDefault()
    }
  }
</script>

<svelte:head>
  <title>Invoices</title>
</svelte:head>

<div class="mx-auto md:w-2/3 w-full px-8 pt-8">
  {#if flash.notice}
    <p class="py-2 px-3 bg-green-50 mb-5 text-green-500 font-medium rounded-lg inline-block">
      {flash.notice}
    </p>
  {/if}

  <div class="flex justify-between items-center">
    <h1 class="font-bold text-4xl">Invoices</h1>
    <Link
      href="/invoices/new"
      class="rounded-lg py-3 px-5 bg-blue-600 text-white block font-medium"
    >
      New invoice
    </Link>
  </div>

  <div class="min-w-full">
    {#each invoices as invoice (invoice.id)}
      <Invoice {invoice} />
      <p>
        <Link
          href={`/invoices/${invoice.id}`}
          class="ml-2 rounded-lg py-3 px-5 bg-gray-100 inline-block font-medium"
        >
          Show this invoice
        </Link>
      </p>
    {/each}
  </div>
</div>
