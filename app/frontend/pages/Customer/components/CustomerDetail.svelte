<script lang="ts">
  let { label, value } = $props();
</script>

<div class="flex justify-between">
  <div class="font-bold">{label}:</div>
  <div>{value}</div>
</div>
