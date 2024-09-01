<script>
  import { Link } from '@inertiajs/svelte'
  import Customer from './Customer.svelte'

  export let customers
  export let flash

  const onDestroy = (e) => {
    if (!confirm('Are you sure you want to delete this customer?')) {
      e.preventDefault()
    }
  }
</script>

<svelte:head>
  <title>Customers</title>
</svelte:head>

<div class="mx-auto md:w-2/3 w-full px-8 pt-8">
  {#if flash.notice}
    <p class="py-2 px-3 bg-green-50 mb-5 text-green-500 font-medium rounded-lg inline-block">
      {flash.notice}
    </p>
  {/if}

  <div class="flex justify-between items-center">
    <h1 class="font-bold text-4xl">Customers</h1>
    <Link
      href="/customers/new"
      class="rounded-lg py-3 px-5 bg-blue-600 text-white block font-medium"
    >
      New customer
    </Link>
  </div>

  <div class="min-w-full">
    {#each customers as customer (customer.id)}
      <Customer {customer} />
      <p>
        <Link
          href={`/customers/${customer.id}`}
          class="ml-2 rounded-lg py-3 px-5 bg-gray-100 inline-block font-medium"
        >
          Show this customer
        </Link>
      </p>
    {/each}
  </div>
</div>
