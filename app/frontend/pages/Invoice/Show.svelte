<script>
  import { inertia, Link } from '@inertiajs/svelte'
  import Invoice from './Invoice.svelte'

  export let invoice
  export let flash

  const onDestroy = (e) => {
    if (!confirm('Are you sure you want to delete this invoice?')) {
      e.preventDefault()
    }
  }
</script>

<svelte:head>
  <title>Invoice #{invoice.id}</title>
</svelte:head>

<div class="mx-auto md:w-2/3 w-full px-8 pt-8">
  <div class="mx-auto">
    {#if flash.notice}
      <p class="py-2 px-3 bg-green-50 mb-5 text-green-500 font-medium rounded-lg inline-block">
        {flash.notice}
      </p>
    {/if}

    <h1 class="font-bold text-4xl">Invoice #{invoice.id}</h1>

    <Invoice {invoice} />

    <Link
      href={`/invoices/${invoice.id}/edit`}
      class="ml-2 rounded-lg py-3 px-5 bg-gray-100 inline-block font-medium"
    >
      Edit this invoice
    </Link>
    <Link
      href="/invoices"
      class="ml-2 rounded-lg py-3 px-5 bg-gray-100 inline-block font-medium"
    >
      Back to invoices
    </Link>
    <div class="inline-block ml-2">
      <button
        use:inertia={{ href: `/invoices/${invoice.id}`, method: 'delete' }}
        on:click={onDestroy}
        type="button"
        class="mt-2 rounded-lg py-3 px-5 bg-gray-100 font-medium"
      >
        Destroy this invoice
      </button>
    </div>
  </div>
</div>




