<script context="module">
export { default as layout } from "../LayoutNav.svelte"
</script>

<script>
import { Link } from "@inertiajs/svelte"
import Invoice from "./Invoice.svelte"

export let invoices
export let flash

const onDestroy = (e) => {
  if (!confirm("Are you sure you want to delete this invoice?")) {
    e.preventDefault()
  }
}
</script>

<svelte:head>
  <title>Invoices</title>
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
    <h1 class="text-4xl font-bold">Invoices</h1>
    <Link
      href="/invoices/new"
      class="block rounded-lg bg-blue-600 px-5 py-3 font-medium text-white"
    >
      New invoice
    </Link>
  </div>

  <div class="min-w-full">
    {#each invoices as invoice (invoice.id)}
      <Invoice invoice={invoice} />
      <p>
        <Link
          href={`/invoices/${invoice.id}`}
          class="ml-2 inline-block rounded-lg bg-gray-100 px-5 py-3 font-medium"
        >
          Show this invoice
        </Link>
      </p>
    {/each}
  </div>
</div>
