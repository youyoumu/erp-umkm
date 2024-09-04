<script>
import { onMount } from "svelte"
import { createGrid } from "ag-grid-community"
import "ag-grid-community/styles/ag-grid.css" // Core grid CSS, always needed
import "ag-grid-community/styles/ag-theme-alpine.css" // Optional theme CSS
export let invoice
export let items

let gridContainer
const columnDefs = [{ field: "make" }, { field: "model" }, { field: "price" }]
const rowData = [
  { make: "Toyota", model: "Celica", price: 35000 },
  { make: "Ford", model: "Mondeo", price: 32000 },
  { make: "Porsche", model: "Boxter", price: 72000 },
]
const gridOptions = {
  columnDefs: columnDefs,
  rowData: rowData,
}

onMount(() => {
  new createGrid(gridContainer, gridOptions)
})
</script>

<div>
  <p class="my-5">
    <strong class="mb-1 block font-medium">Date:</strong>
    {invoice.date}
  </p>
  <p class="my-5">
    <strong class="mb-1 block font-medium">Code:</strong>
    {invoice.code}
  </p>
</div>

<div id="datagrid" class="ag-theme-alpine" style="height: 600px; width:500px;" bind:this={gridContainer}></div>
