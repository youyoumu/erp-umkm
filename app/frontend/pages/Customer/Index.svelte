<script lang="ts">
  import 'ag-grid-community/styles/ag-grid.css'
  import 'ag-grid-community/styles/ag-theme-quartz.css'

  import { Link } from '@inertiajs/svelte'
  import type { GridOptions } from 'ag-grid-community'
  import { createGrid } from 'ag-grid-community'
  import dayjs from 'dayjs'
  import { mount } from 'svelte'

  import { cellRendererFactory } from '$lib/cellRendererFactory'
  import Button from '$lib/components/ui/button/button.svelte'
  import Input from '$lib/components/ui/input/input.svelte'
  import type { Customer } from '$types/typelizer'

  import CustomerDetailLink from './components/CustomerDetailLink.svelte'

  let {
    customers,
    flash,
  }: {
    customers: Customer[]
    flash: any
  } = $props()

  let gridApi: ReturnType<typeof createGrid<Customer>>

  function agGrid(el: HTMLElement) {
    const gridOptions: GridOptions<Customer> = {
      columnDefs: [
        {
          field: 'name',
          headerName: 'Nama',
          flex: 1,
          width: 70,
          cellRenderer: cellRendererFactory((c, p) => {
            mount(CustomerDetailLink, {
              target: c.getGui(),
              props: { customer: p.data },
            })
          }),
        },
        {
          field: 'contact',
          width: 150,
          headerName: 'Kontak',
          wrapHeaderText: true,
        },
        {
          field: 'address',
          width: 200,
          headerName: 'Alamat',
          wrapHeaderText: true,
        },
        {
          field: 'updated_at',
          width: 115,
          headerName: 'Terakhir Diubah',
          wrapHeaderText: true,
        },
      ],
      rowData: customers.map((customer) => {
        return {
          ...customer,
          updated_at: dayjs(customer.updated_at).format('DD MMM YY'),
        }
      }),
    }

    gridApi = createGrid(el, gridOptions)
  }

  function handleAgGridSearch(text: string) {
    gridApi.setGridOption('quickFilterText', text)
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

  <Input
    oninput={(e) => handleAgGridSearch(e.currentTarget.value)}
    placeholder="Cari Pembeli"
    class="mb-4"
  />
  <div use:agGrid class="h-[60svh] w-full ag-theme-quartz"></div>
</div>
