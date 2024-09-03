<script>
export let errors
</script>

{#if errors}
  <div class="text-sm font-medium text-destructive">
    {errors.join(', ')}
  </div>
{/if}
