<script>
import { onMount } from "svelte"
import { createGrid } from "ag-grid-community"
import "ag-grid-community/styles/ag-grid.css"
import "ag-grid-community/styles/ag-theme-alpine.css"
export let invoice
export let items
console.log(items)

let gridContainer
const columnDefs = [{ field: "name" }, { field: "quantity" }, { field: "quantity_unit" }, { field: "selling_price" }, { field: "total" }]
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

<div class="mb-8 flex gap-4">
  <div>Date: {invoice.date}</div>
  <div>Code: {invoice.code}</div>
  <div>Address: {invoice.address}</div>
</div>
<div id="datagrid" class="ag-theme-alpine size-full" bind:this={gridContainer}></div>
