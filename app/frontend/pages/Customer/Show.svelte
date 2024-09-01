<script>
  import { inertia, Link } from '@inertiajs/svelte'
  import Customer from './Customer.svelte'

  export let customer
  export let flash

  const onDestroy = (e) => {
    if (!confirm('Are you sure you want to delete this customer?')) {
      e.preventDefault()
    }
  }
</script>

<svelte:head>
  <title>Customer #{customer.id}</title>
</svelte:head>

<div class="mx-auto md:w-2/3 w-full px-8 pt-8">
  <div class="mx-auto">
    {#if flash.notice}
      <p class="py-2 px-3 bg-green-50 mb-5 text-green-500 font-medium rounded-lg inline-block">
        {flash.notice}
      </p>
    {/if}

    <h1 class="font-bold text-4xl">Customer #{customer.id}</h1>

    <Customer {customer} />

    <Link
      href={`/customers/${customer.id}/edit`}
      class="ml-2 rounded-lg py-3 px-5 bg-gray-100 inline-block font-medium"
    >
      Edit this customer
    </Link>
    <Link
      href="/customers"
      class="ml-2 rounded-lg py-3 px-5 bg-gray-100 inline-block font-medium"
    >
      Back to customers
    </Link>
    <div class="inline-block ml-2">
      <button
        use:inertia={{ href: `/customers/${customer.id}`, method: 'delete' }}
        on:click={onDestroy}
        type="button"
        class="mt-2 rounded-lg py-3 px-5 bg-gray-100 font-medium"
      >
        Destroy this customer
      </button>
    </div>
  </div>
</div>




