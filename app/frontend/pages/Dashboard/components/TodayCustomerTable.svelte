<script lang="ts">
  import 'ag-grid-community/styles/ag-grid.css'
  import 'ag-grid-community/styles/ag-theme-quartz.css'

  import type { GridOptions } from 'ag-grid-community'
  import { createGrid } from 'ag-grid-community'
  import dayjs from 'dayjs'
  import { mount } from 'svelte'

  import { cellRendererFactory } from '$lib/cellRendererFactory'
  import Input from '$lib/components/ui/input/input.svelte'
  import { formatIDR, sum } from '$lib/utils'
  import type { Customer } from '$types/typelizer'

  import CustomerDetailLink from './CustomerDetailLink.svelte'
  let {
    customers,
  }: {
    customers: Customer[]
  } = $props()

  let gridApi: ReturnType<
    typeof createGrid<Customer & { today_total_invoices: string }>
  >

  function agGrid(el: HTMLElement) {
    const gridOptions: GridOptions<
      Customer & { today_total_invoices: string }
    > = {
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
          field: 'today_total_invoices',
          width: 140,
          headerName: 'Total Belanja Hari Ini',
          wrapHeaderText: true,
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
          today_total_invoices: formatIDR(
            sum(
              customer.today_invoices.map((invoice) =>
                sum(
                  invoice.items.map(
                    (item) => item.quantity * item.selling_price
                  )
                )
              )
            )
          ),
        }
      }),
    }

    gridApi = createGrid(el, gridOptions)
  }

  function handleAgGridSearch(text: string) {
    gridApi.setGridOption('quickFilterText', text)
  }
</script>

<div class="flex flex-col gap-2 h-[40svh] size-full">
  <Input
    oninput={(e) => handleAgGridSearch(e.currentTarget.value)}
    placeholder="Cari Pelanggan"
  />
  <div use:agGrid class="h-full w-full ag-theme-quartz"></div>
</div>
