<script lang="ts">
  // export { default as layout } from '../../lib/components/LayoutNav.svelte'
  import * as AlertDialog from '$lib/components/ui/alert-dialog'
  import Button from '$lib/components/ui/button/button.svelte'
  import { inertia, router } from '@inertiajs/svelte'
  import { Printer } from 'lucide-svelte'
  import Invoice from './Invoice.svelte'

  let { invoice, flash } = $props()

  const onDestroy = (e) => {
    router.delete(`/invoices/${invoice.id}`)
  }
</script>

<svelte:head>
  <title>Nota #{invoice.id}</title>
</svelte:head>

<div class="relative flex size-full flex-col items-center py-8">
  {#if flash.notice}
    <p
      class="mb-5 inline-block rounded-lg bg-green-50 px-3 py-2 font-medium text-green-500"
    >
      {flash.notice}
    </p>
  {/if}

  <a
    href={`/invoices/${invoice.id}/display_invoice`}
    target="_blank"
    class="absolute right-0 top-8 cursor-pointer rounded-full border border-slate-300 bg-slate-200 p-2 shadow-sm"
    ><Printer /></a
  >

  <div class="mb-4 flex w-full items-center gap-4">
    <h1 class="text-4xl font-bold">Nota #{invoice.id}</h1>
    <a href={`/invoices/${invoice.id}/edit`} use:inertia>
      <Button variant="secondary">Edit Nota</Button>
    </a>
    <AlertDialog.Root>
      <AlertDialog.Trigger
        ><Button variant="destructive">Hapus Nota</Button></AlertDialog.Trigger
      >
      <AlertDialog.Content>
        <AlertDialog.Header>
          <AlertDialog.Title
            >Apakah kamu yakin ingin menghapus nota ini?</AlertDialog.Title
          >
          <AlertDialog.Description></AlertDialog.Description>
        </AlertDialog.Header>
        <AlertDialog.Footer>
          <AlertDialog.Cancel>Batal</AlertDialog.Cancel>
          <AlertDialog.Action
            on:click={onDestroy}
            class="bg-red-600 hover:bg-red-700">Hapus</AlertDialog.Action
          >
        </AlertDialog.Footer>
      </AlertDialog.Content>
    </AlertDialog.Root>
  </div>
  <Invoice {invoice} items={invoice.items} />
</div>
