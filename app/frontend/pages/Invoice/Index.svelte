<script context="module">
export { default as layout } from "../LayoutNav.svelte"
</script>

<script>
import { Link, inertia } from "@inertiajs/svelte"
import Button from "$lib/components/ui/button/button.svelte"
export let invoices
export let flash
import { onMount } from "svelte"
import { createGrid } from "ag-grid-community"
import "ag-grid-community/styles/ag-grid.css"
import "ag-grid-community/styles/ag-theme-alpine.css"
import { formatIDR, cn } from "$lib/utils"
import dayjs from "dayjs"
import Input from "$lib/components/ui/input/input.svelte"
import { cellRendererFactory } from "$lib/cellRendererFactory"
import InvoiceDetailLink from "./components/InvoiceDetailLink.svelte"

let gridContainer
const columnDefs = [
  {
    field: "code",
    headerName: "Kode Nota",
    flex: 1,
    cellRenderer: cellRendererFactory((c, p) => {
      console.log(p)
      new InvoiceDetailLink({
        target: c.eGui,
        props: {
          invoice: p.data,
        },
      })
    }),
  },
  { field: "date", headerName: "Tanggal", width: 115 },
  { field: "address", headerName: "Alamat", width: 320 },
]
const gridOptions = {
  columnDefs: columnDefs,
  rowData: invoices.map((invoice) => {
    return {
      ...invoice,
      date: dayjs(invoice.date).format("DD/MMM/YY"),
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
  <title>Invoices</title>
</svelte:head>

<div class="w-full p-8">
  {#if flash.notice}
    <p class="mb-5 inline-block rounded-lg bg-green-50 px-3 py-2 font-medium text-green-500">
      {flash.notice}
    </p>
  {/if}

  <div class="mb-8 flex items-center justify-between">
    <h1 class="text-4xl font-bold">Daftar Nota</h1>
    <a href="/invoices/new" use:inertia><Button>Nota Baru</Button></a>
  </div>

  <Input on:input={handleSearch} placeholder="Cari Barang" class="mb-4" />
  <div id="datagrid" class={cn("ag-theme-alpine h-[60svh] w-full")} bind:this={gridContainer}></div>
</div>
