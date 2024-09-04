<script>
import { onMount } from "svelte"
import { createGrid } from "ag-grid-community"
import "ag-grid-community/styles/ag-grid.css"
import "ag-grid-community/styles/ag-theme-alpine.css"
import { cn } from "$lib/utils"
export let invoice
export let items
console.log(items)

// path /print
const isPrint = window.location.pathname.endsWith("/print")

let gridContainer
const columnDefs = [
  { field: "name", flex: 1, headerName: "Nama Barang" },
  { field: "quantity", width: 135, headerName: "Jumlah Barang", wrapHeaderText: true },
  { field: "quantity_unit", width: 85, headerName: "Satuan" },
  { field: "selling_price", width: 125, headerName: "Harga Satuan", wrapHeaderText: true },
  { field: "total", width: 125 },
]
const gridOptions = {
  columnDefs: columnDefs,
  rowData: items.map((item) => {
    return {
      ...item,
      total: item.quantity * item.selling_price,
    }
  }),
  domLayout: isPrint ? "print" : "",
}

const total = items.reduce((total, item) => total + item.selling_price * item.quantity, 0)

onMount(() => {
  new createGrid(gridContainer, gridOptions)
  if (isPrint) window.print()
})
</script>

<div class="mb-4 w-full p-4">
  <div class="mb-4 flex gap-4">
    <div><span class="font-bold">Tanggal:</span> {invoice.date}</div>
    <div><span class="font-bold">Kode Nota:</span> {invoice.code}</div>
  </div>
  <div><span class="font-bold">Alamat:</span> {invoice.address}</div>
</div>

<div id="datagrid" class={cn("ag-theme-alpine w-full justify-center", isPrint ? "flex" : "h-full")} bind:this={gridContainer}></div>

<div class="flex w-full justify-between p-4 text-lg">
  <div class="font-bold">Total:</div>
  <div class="font-bold">{total}</div>
</div>

<style>
@media print {
  @page {
    size: potrait;
    margin: 0;
  }
}
</style>
