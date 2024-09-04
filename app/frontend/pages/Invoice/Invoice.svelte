<script>
import { onMount } from "svelte"
import { createGrid } from "ag-grid-community"
import "ag-grid-community/styles/ag-grid.css"
import "ag-grid-community/styles/ag-theme-alpine.css"
export let invoice
export let items
console.log(items)

let gridContainer
const columnDefs = [
  { field: "name", flex: 1, headerName: "Nama Barang" },
  { field: "quantity", width: 140, headerName: "Jumlah Barang" },
  { field: "quantity_unit", width: 100, headerName: "Satuan" },
  { field: "selling_price", width: 130, headerName: "Harga Satuan" },
  { field: "total", width: 130 },
]
const gridOptions = {
  columnDefs: columnDefs,
  rowData: items.map((item) => {
    return {
      ...item,
      total: item.quantity * item.selling_price,
    }
  }),
}

const total = items.reduce((total, item) => total + item.selling_price * item.quantity, 0)

onMount(() => {
  new createGrid(gridContainer, gridOptions)
})
</script>

<div class="col mb-8">
  <div class="mb-4 flex gap-4">
    <div><span class="font-bold">Tanggal:</span> {invoice.date}</div>
    <div><span class="font-bold">Kode Nota:</span> {invoice.code}</div>
  </div>
  <div><span class="font-bold">Alamat:</span> {invoice.address}</div>
</div>
<div id="datagrid" class="ag-theme-alpine h-full w-full" bind:this={gridContainer}></div>
<div class="flex w-full justify-between border-b-2 border-slate-300 p-4 text-lg">
  <div class="font-bold">Total:</div>
  <div class="font-bold">{total}</div>
</div>
