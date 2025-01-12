<script lang="ts">
  import { createGrid, type GridOptions } from 'ag-grid-community'
  import dayjs from 'dayjs'
  import { Construction } from 'lucide-svelte'
  import { mount } from 'svelte'

  import { cellRendererFactory } from '$lib/cellRendererFactory'
  import Input from '$lib/components/ui/input/input.svelte'
  import { cn } from '$lib/utils'
  import { formatIDR } from '$lib/utils'
  import type { Customer, Invoice } from '$types/typelizer'

  import CustomerDetailLink from './CustomerDetailLink.svelte'
  import InvoiceDetailLink from './InvoiceDetailLink.svelte'

  let {
    invoices,
  }: {
    invoices: Invoice[]
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
        headerName: 'Pelanggan',
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
        date: dayjs(invoice.date).format('DD MMM YY'),
        total: formatIDR(total),
      }
    }),
  }

  let gridApi: ReturnType<typeof createGrid<Invoice & { total: string }>>
  $effect(() => {
    gridApi = createGrid(gridContainer!, gridOptions)
    return gridApi.destroy
  })

  function handleSearch(text: string) {
    gridApi.setGridOption('quickFilterText', text)
  }
</script>

<div class="flex flex-col gap-2 h-[40svh] size-full">
  <Input
    oninput={(e) => handleSearch(e.currentTarget.value)}
    placeholder="Cari Nota"
  />
  <div
    id="datagrid"
    class={cn('ag-theme-quartz  w-full h-full')}
    bind:this={gridContainer}
  ></div>
</div>
