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
  { field: "quantity", headerName: "Jumlah Barang" },
  { field: "quantity_unit", headerName: "Satuan" },
  { field: "selling_price", headerName: "Harga Satuan" },
  { field: "total" },
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
