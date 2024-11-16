<script lang="ts">
  let { errors } = $props();
</script>

{#if errors}
  <div class="text-sm font-medium text-destructive">
    {errors.join(', ')}
  </div>
{/if}
