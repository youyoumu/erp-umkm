<script lang="ts">
  import 'ag-grid-community/styles/ag-grid.css'
  import 'ag-grid-community/styles/ag-theme-quartz.css'

  import { Link } from '@inertiajs/svelte'
  import type { GridOptions } from 'ag-grid-community'
  import { createGrid } from 'ag-grid-community'

  import Button from '$lib/components/ui/button/button.svelte'
  import type { Customer } from '$types/typelizer'

  let {
    customers,
    flash,
  }: {
    customers: Customer[]
    flash: any
  } = $props()

  function agGrid(el: HTMLElement) {
    const gridOptions: GridOptions<Customer> = {
      columnDefs: [
        {
          field: 'name',
          headerName: 'Nama',
          flex: 1,
          width: 70,
        },
      ],
      rowData: customers,
    }

    createGrid(el, gridOptions)
  }
</script>

<svelte:head>
  <title>Customers</title>
</svelte:head>

<div class="w-full p-8">
  {#if flash.notice}
    <p
      class="mb-5 inline-block rounded-lg bg-green-50 px-3 py-2 font-medium text-green-500"
    >
      {flash.notice}
    </p>
  {/if}

  <div class="mb-8 flex items-center justify-between">
    <h1 class="text-4xl font-bold">Daftar Pembeli</h1>
    <Link href="/customers/new"><Button>Pembeli Baru</Button></Link>
  </div>

  <div use:agGrid class="h-[60svh] w-full ag-theme-quartz"></div>
</div>
