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
  import { cn, formatIDR } from '$lib/utils'
  import type { Item } from '$types/typelizer'

  import CsvExportButton from './components/CSVExportButton.svelte'
  import CsvInputButton from './components/CSVInputButton.svelte'
  import DeleteItemButton from './components/DeleteItemButton.svelte'
  import ItemDetailLink from './components/ItemDetailLink.svelte'

  let {
    items,
    flash,
  }: {
    items: Item[]
    flash: any
  } = $props()

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
        {
          width: 80,
          headerName: 'Hapus',
          wrapHeaderText: true,
          cellRenderer: cellRendererFactory((c, p) => {
            mount(DeleteItemButton, {
              target: c.getGui(),
              props: { item: p.data },
            })
          }),
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

<svelte:head>
  <title>Items</title>
</svelte:head>

<div class="size-full p-8">
  {#if flash.notice}
    <p
      class="mb-5 inline-block rounded-lg bg-green-50 px-3 py-2 font-medium text-green-500"
    >
      {flash.notice}
    </p>
  {/if}

  <div class="mb-8 flex items-center justify-between">
    <h1 class="text-4xl font-bold">Daftar Barang</h1>
    <div class="flex gap-2">
      <CsvExportButton />
      <CsvInputButton />
      <Link href="/items/new"><Button>Barang Baru</Button></Link>
    </div>
  </div>
  <Input
    oninput={(e) => handleSearch(e.currentTarget.value)}
    placeholder="Cari Barang"
    class="mb-4"
  />
  <div
    id="datagrid"
    class={cn('ag-theme-quartz h-[60svh] w-full')}
    bind:this={gridContainer}
  ></div>
</div>
