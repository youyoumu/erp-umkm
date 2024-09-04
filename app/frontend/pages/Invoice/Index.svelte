<script context="module">
export { default as layout } from "../LayoutNav.svelte"
</script>

<script>
import { Link, inertia } from "@inertiajs/svelte"
import Button from "$lib/components/ui/button/button.svelte"
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

<div class="w-full p-8">
  {#if flash.notice}
    <p class="mb-5 inline-block rounded-lg bg-green-50 px-3 py-2 font-medium text-green-500">
      {flash.notice}
    </p>
  {/if}

  <div class="mb-8 flex items-center justify-between">
    <h1 class="text-4xl font-bold">Daftar Nota</h1>
    <a href="/invoices/new" use:inertia><Button>Nota Baru</Button></a>
  </div>

  <div class="min-w-full">
    {#each invoices as invoice (invoice.id)}
      <p>
        <Link href={`/invoices/${invoice.id}`} class="text-blue-600 underline">
          {invoice.code}
        </Link>
      </p>
    {/each}
  </div>
</div>
