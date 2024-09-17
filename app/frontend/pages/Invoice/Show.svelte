<script context="module">
export { default as layout } from "../LayoutNav.svelte"
</script>

<script>
import { inertia, Link } from "@inertiajs/svelte"
import Invoice from "./Invoice.svelte"
import { Printer } from "lucide-svelte"

export let invoice
export let items
export let flash

const onDestroy = (e) => {
  if (!confirm("Are you sure you want to delete this invoice?")) {
    e.preventDefault()
  }
}
</script>

<svelte:head>
  <title>Nota #{invoice.id}</title>
</svelte:head>

<div class="relative flex size-full flex-col items-center py-8">
  {#if flash.notice}
    <p class="mb-5 inline-block rounded-lg bg-green-50 px-3 py-2 font-medium text-green-500">
      {flash.notice}
    </p>
  {/if}

  <a
    href={`/invoices/${invoice.id}/display_invoice`}
    target="_blank"
    class="absolute right-0 top-8 cursor-pointer rounded-full border border-slate-300 bg-slate-200 p-2 shadow-sm"><Printer /></a
  >

  <h1 class="mb-4 text-4xl font-bold">Nota #{invoice.id}</h1>
  <Invoice invoice={invoice} items={items} />

  <!-- 
  <Link href={`/invoices/${invoice.id}/edit`} class="ml-2 inline-block rounded-lg bg-gray-100 px-5 py-3 font-medium">
    Edit this invoice
  </Link>
  <Link href="/invoices" class="ml-2 inline-block rounded-lg bg-gray-100 px-5 py-3 font-medium">Back to invoices</Link>
  <div class="ml-2 inline-block">
    <button
      use:inertia={{ href: `/invoices/${invoice.id}`, method: 'delete' }}
      on:click={onDestroy}
      type="button"
      class="mt-2 rounded-lg bg-gray-100 px-5 py-3 font-medium"
    >
      Destroy this invoice
    </button>
  </div> -->
</div>
