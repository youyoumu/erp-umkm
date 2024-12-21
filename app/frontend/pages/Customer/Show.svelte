<script lang="ts">
  import { inertia, router } from '@inertiajs/svelte'

  import * as AlertDialog from '$lib/components/ui/alert-dialog'
  import Button from '$lib/components/ui/button/button.svelte'
  import { Textarea } from '$lib/components/ui/textarea'
  import type { Customer } from '$types/typelizer'

  import CustomerDetail from './components/CustomerDetail.svelte'

  let {
    customer,
    flash,
  }: {
    customer: Customer
    flash: any
  } = $props()

  const onDestroy = () => {
    router.delete(`/customers/${customer.id}`)
  }
</script>

<svelte:head>
  <title>Pembeli #{customer.id}</title>
</svelte:head>

<div class="mx-auto max-w-screen-sm p-8">
  <div class="mx-auto">
    {#if flash.notice}
      <p
        class="mb-5 inline-block rounded-lg bg-green-50 px-3 py-2 font-medium text-green-500"
      >
        {flash.notice}
      </p>
    {/if}

    <h1 class="mb-4 text-4xl font-bold">Pembeli #{customer.id}</h1>

    <div class="flex flex-col gap-1">
      <CustomerDetail label="Nama" value={customer.name} />
      <CustomerDetail label="Alamat" value={customer.address} />
      <CustomerDetail label="Kontak" value={customer.contact} />
    </div>
    <div class="my-4">
      <div class="mb-2 font-bold">Catatan:</div>
      <Textarea bind:value={customer.notes} readonly></Textarea>
    </div>

    <div class="flex gap-2">
      <a href={`/customers/${customer.id}/edit`} use:inertia
        ><Button variant="secondary">Edit</Button></a
      >
      <AlertDialog.Root>
        <AlertDialog.Trigger
          ><Button variant="destructive">Hapus</Button></AlertDialog.Trigger
        >
        <AlertDialog.Content>
          <AlertDialog.Header>
            <AlertDialog.Title
              >Apakah kamu yakin ingin menghapus pembeli ini?</AlertDialog.Title
            >
            <AlertDialog.Description>
              <!-- This action cannot be undone. This will permanently delete your account and remove your data from our servers. -->
            </AlertDialog.Description>
          </AlertDialog.Header>
          <AlertDialog.Footer>
            <AlertDialog.Cancel>Batal</AlertDialog.Cancel>
            <AlertDialog.Action
              onclick={onDestroy}
              class="bg-red-600 hover:bg-red-700">Hapus</AlertDialog.Action
            >
          </AlertDialog.Footer>
        </AlertDialog.Content>
      </AlertDialog.Root>
    </div>
  </div>
</div>
