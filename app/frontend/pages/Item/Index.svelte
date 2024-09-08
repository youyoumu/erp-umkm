<script context="module">
export { default as layout } from "../LayoutNav.svelte"
</script>

<script>
import { cn } from "$lib/utils"
import { Link, inertia } from "@inertiajs/svelte"
import Button from "$lib/components/ui/button/button.svelte"
import { onMount } from "svelte"
import { createGrid } from "ag-grid-community"
import "ag-grid-community/styles/ag-grid.css"
import "ag-grid-community/styles/ag-theme-quartz.css"
import { formatIDR } from "$lib/utils"
import dayjs from "dayjs"
import Input from "$lib/components/ui/input/input.svelte"
import { cellRendererFactory } from "$lib/cellRendererFactory"
import ItemDetailLink from "./components/ItemDetailLink.svelte"

export let items
export let flash

let gridContainer
const columnDefs = [
  {
    field: "name",
    cellRenderer: cellRendererFactory((c, p) => {
      new ItemDetailLink({
        target: c.eGui,
        props: {
          item: p.data,
        },
      })
    }),
    headerName: "Nama Barang",
    flex: 1,
    width: 70,
  },
  { field: "stock", headerName: "Stok", width: 85 },

  { field: "quantity_unit", width: 85, headerName: "Satuan" },
  { field: "selling_price", width: 125, headerName: "Harga Satuan", wrapHeaderText: true },
  { field: "updated_at", width: 115, headerName: "Terakhir Diubah Pada", wrapHeaderText: true },
]
const gridOptions = {
  columnDefs: columnDefs,
  rowData: items.map((item) => {
    return {
      ...item,
      selling_price: formatIDR(item.selling_price),
      updated_at: dayjs(item.updated_at).format("DD/MMM/YY"),
    }
  }),
}

let gridApi
onMount(() => {
  gridApi = createGrid(gridContainer, gridOptions)
})

function handleSearch(e) {
  gridApi.setGridOption("quickFilterText", e.target.value)
}
</script>

<svelte:head>
  <title>Items</title>
</svelte:head>

<div class="size-full p-8">
  {#if flash.notice}
    <p class="mb-5 inline-block rounded-lg bg-green-50 px-3 py-2 font-medium text-green-500">
      {flash.notice}
    </p>
  {/if}

  <div class="mb-8 flex items-center justify-between">
    <h1 class="text-4xl font-bold">Daftar Barang</h1>
    <a href="/items/new" use:inertia><Button>Barang Baru</Button></a>
  </div>
  <Input on:input={handleSearch} placeholder="Cari Barang" class="mb-4" />
  <div id="datagrid" class={cn("ag-theme-quartz h-[60svh] w-full")} bind:this={gridContainer}></div>
</div>
