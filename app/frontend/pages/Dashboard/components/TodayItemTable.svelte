<script lang="ts">
  import 'ag-grid-community/styles/ag-grid.css'
  import 'ag-grid-community/styles/ag-theme-quartz.css'

  import type { GridOptions } from 'ag-grid-community'
  import { createGrid } from 'ag-grid-community'
  import dayjs from 'dayjs'
  import { mount } from 'svelte'

  import { cellRendererFactory } from '$lib/cellRendererFactory'
  import Input from '$lib/components/ui/input/input.svelte'
  import { cn, formatIDR } from '$lib/utils'
  import type { Item } from '$types/typelizer'

  import ItemDetailLink from './ItemDetailLink.svelte'

  let {
    items,
  }: {
    items: Item[]
  } = $props()

  $inspect(items)

  const gridOptions: GridOptions<Item & { selling_price_IDR: string }> =
    $derived({
      columnDefs: [
        {
          field: 'name',
          cellRenderer: cellRendererFactory((c, p) => {
            mount(ItemDetailLink, {
              target: c.getGui(),
              props: { item: p.data },
            })
          }),
          headerName: 'Nama Barang',
          flex: 1,
          width: 70,
        },
        { field: 'stock', headerName: 'Stok', width: 85 },
        { field: 'quantity_unit', width: 85, headerName: 'Satuan' },
        {
          field: 'selling_price_IDR',
          width: 125,
          headerName: 'Harga Satuan',
          wrapHeaderText: true,
        },
        {
          field: 'updated_at',
          width: 115,
          headerName: 'Terakhir Diubah',
          wrapHeaderText: true,
        },
      ],
      rowData: items.map((item) => {
        return {
          ...item,
          selling_price_IDR: formatIDR(item.selling_price),
          updated_at: dayjs(item.updated_at).format('DD MMM YY'),
        }
      }),
    })

  let gridContainer = $state<HTMLDivElement>()

  let gridApi: ReturnType<
    typeof createGrid<Item & { selling_price_IDR: string }>
  >
  $effect(() => {
    gridApi = createGrid(gridContainer!, gridOptions)
    return () => {
      gridApi.destroy()
    }
  })

  function handleSearch(text: string) {
    gridApi.setGridOption('quickFilterText', text)
  }
</script>

<div class="flex flex-col gap-2 h-[40svh] size-full">
  <Input
    oninput={(e) => handleSearch(e.currentTarget.value)}
    placeholder="Cari Barang"
  />
  <div
    id="datagrid"
    class={cn('ag-theme-quartz h-full w-full')}
    bind:this={gridContainer}
  ></div>
</div>
