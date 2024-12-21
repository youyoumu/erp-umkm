<script lang="ts">
  import { Trash2 } from 'lucide-svelte'

  import DeleteItemDialog from '$lib/components/DeleteItemDialog.svelte'
  import type { Item } from '$types/typelizer'
  let { item } = $props<{ item: Item }>()
</script>

{#snippet trigger()}
  <Trash2 class="text-destructive" />
{/snippet}

<div class="size-full flex items-center justify-center">
  <DeleteItemDialog {item} {trigger} />
</div>
