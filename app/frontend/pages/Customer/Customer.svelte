<script lang="ts">
  let { customer } = $props()
</script>

<div>
  <p class="my-5">
    <strong class="mb-1 block font-medium">Name:</strong>
    {customer.name}
  </p>
  <p class="my-5">
    <strong class="mb-1 block font-medium">Notes:</strong>
    {customer.notes}
  </p>
  <p class="my-5">
    <strong class="mb-1 block font-medium">Address:</strong>
    {customer.address}
  </p>
  <p class="my-5">
    <strong class="mb-1 block font-medium">Contact:</strong>
    {customer.contact}
  </p>
</div>
