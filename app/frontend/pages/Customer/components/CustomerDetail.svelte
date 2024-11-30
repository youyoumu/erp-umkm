<script lang="ts">
  let {
    label,
    value,
  }: {
    label: string | null
    value: string | null
  } = $props()
</script>

<div class="flex justify-between">
  <div class="font-bold">{label}:</div>
  <div>{value}</div>
</div>
