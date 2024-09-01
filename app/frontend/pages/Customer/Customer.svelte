<script>
  export let customer
</script>

<div>
  <p class="my-5">
    <strong class="block font-medium mb-1">Name:</strong>
    {customer.name}
  </p>
  <p class="my-5">
    <strong class="block font-medium mb-1">Notes:</strong>
    {customer.notes}
  </p>
  <p class="my-5">
    <strong class="block font-medium mb-1">Address:</strong>
    {customer.address}
  </p>
  <p class="my-5">
    <strong class="block font-medium mb-1">Contact:</strong>
    {customer.contact}
  </p>
</div>
