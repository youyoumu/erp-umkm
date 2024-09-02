<script>
import { Link } from "@inertiajs/svelte"
import Customer from "./Customer.svelte"

export let customers
export let flash

const onDestroy = (e) => {
  if (!confirm("Are you sure you want to delete this customer?")) {
    e.preventDefault()
  }
}
</script>

<svelte:head>
  <title>Customers</title>
</svelte:head>

<div class="mx-auto w-full px-8 pt-8 md:w-2/3">
  {#if flash.notice}
    <p
      class="mb-5 inline-block rounded-lg bg-green-50 px-3 py-2 font-medium text-green-500"
    >
      {flash.notice}
    </p>
  {/if}

  <div class="flex items-center justify-between">
    <h1 class="text-4xl font-bold">Customers</h1>
    <Link
      href="/customers/new"
      class="block rounded-lg bg-blue-600 px-5 py-3 font-medium text-white"
    >
      New customer
    </Link>
  </div>

  <div class="min-w-full">
    {#each customers as customer (customer.id)}
      <Customer customer={customer} />
      <p>
        <Link
          href={`/customers/${customer.id}`}
          class="ml-2 inline-block rounded-lg bg-gray-100 px-5 py-3 font-medium"
        >
          Show this customer
        </Link>
      </p>
    {/each}
  </div>
</div>
