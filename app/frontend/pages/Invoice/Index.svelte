<script lang="ts">
  import 'ag-grid-community/styles/ag-grid.css'
  import 'ag-grid-community/styles/ag-theme-quartz.css'

  import { inertia } from '@inertiajs/svelte'
  import type { GridOptions } from 'ag-grid-community'
  import { createGrid } from 'ag-grid-community'
  import dayjs from 'dayjs'
  import { mount, onMount } from 'svelte'

  import { cellRendererFactory } from '$lib/cellRendererFactory'
  import Button from '$lib/components/ui/button/button.svelte'
  import Input from '$lib/components/ui/input/input.svelte'
  import { cn, formatIDR } from '$lib/utils'
  import type { Invoice } from '$types/typelizer'

  import CustomerDetailLink from './components/CustomerDetailLink.svelte'
  import InvoiceDetailLink from './components/InvoiceDetailLink.svelte'

  let {
    invoices,
    flash,
  }: {
    invoices: Invoice[]
    flash: any
  } = $props()

  let gridContainer = $state<HTMLDivElement>()
  const gridOptions: GridOptions<Invoice & { total: string }> = {
    columnDefs: [
      {
        field: 'code',
        headerName: 'Kode Nota',
        flex: 1,
        cellRenderer: cellRendererFactory((c, p) => {
          mount(InvoiceDetailLink, {
            target: c.eGui,
            props: {
              invoice: p.data,
            },
          })
        }),
      },
      {
        field: 'customer',
        headerName: 'Pembeli',
        width: 160,
        cellRenderer: cellRendererFactory((c, p) => {
          mount(CustomerDetailLink, {
            target: c.eGui,
            props: {
              customer: p.data.customer,
            },
          })
        }),
        getQuickFilterText: (params) => {
          return params.data.customer?.name ?? ''
        },
        valueGetter: (params) => {
          return params.data ? params.data.customer?.name : ''
        },
      },
      { field: 'total', headerName: 'Total', width: 135 },
      { field: 'date', headerName: 'Tanggal', width: 115 },
      { field: 'address', headerName: 'Alamat', width: 240 },
    ],
    rowData: invoices.map((invoice) => {
      const total = invoice.items.reduce((total, item) => {
        if (item.quantity === 0) return total
        return total + item.selling_price * item.quantity
      }, 0)
      return {
        ...invoice,
        date: dayjs(invoice.date).format('DD/MMM/YY'),
        total: formatIDR(total),
      }
    }),
  }

  let gridApi: ReturnType<typeof createGrid<Invoice & { total: string }>>
  onMount(() => {
    gridApi = createGrid(gridContainer!, gridOptions)
  })

  function handleSearch(text: string) {
    gridApi.setGridOption('quickFilterText', text)
  }
</script>

<svelte:head>
  <title>Invoices</title>
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
    <h1 class="text-4xl font-bold">Daftar Nota</h1>
    <a href="/invoices/new" use:inertia><Button>Nota Baru</Button></a>
  </div>

  <Input
    oninput={(e) => handleSearch(e.currentTarget.value)}
    placeholder="Cari Nota"
    class="mb-4"
  />
  <div
    id="datagrid"
    class={cn('ag-theme-quartz h-[60svh] w-full')}
    bind:this={gridContainer}
  ></div>
</div>
