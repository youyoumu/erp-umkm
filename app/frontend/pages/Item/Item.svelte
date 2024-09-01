<script>
  export let item
</script>

<div>
  <p class="my-5">
    <strong class="block font-medium mb-1">Name:</strong>
    {item.name}
  </p>
  <p class="my-5">
    <strong class="block font-medium mb-1">Notes:</strong>
    {item.notes}
  </p>
  <p class="my-5">
    <strong class="block font-medium mb-1">Cost price:</strong>
    {item.cost_price}
  </p>
  <p class="my-5">
    <strong class="block font-medium mb-1">Selling price:</strong>
    {item.selling_price}
  </p>
  <p class="my-5">
    <strong class="block font-medium mb-1">Stock:</strong>
    {item.stock}
  </p>
  <p class="my-5">
    <strong class="block font-medium mb-1">Code:</strong>
    {item.code}
  </p>
  <p class="my-5">
    <strong class="block font-medium mb-1">Category:</strong>
    {item.category}
  </p>
</div>
