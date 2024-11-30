<script lang="ts">
  interface Props {
    children?: import('svelte').Snippet
  }

  let { children }: Props = $props()
</script>

<div class="flex flex-col gap-2">
  {@render children?.()}
</div>
