<script lang="ts">
  import { router } from '@inertiajs/svelte'
  import type { Snippet } from 'svelte'

  import * as AlertDialog from '$lib/components/ui/alert-dialog'
  import type { Item } from '$types/typelizer'

  let { item, trigger } = $props<{ item: Item; trigger: Snippet }>()

  const onDestroy = () => {
    router.delete(`/items/${item.id}`)
  }
</script>

<AlertDialog.Root>
  <AlertDialog.Trigger>{@render trigger()}</AlertDialog.Trigger>
  <AlertDialog.Content>
    <AlertDialog.Header>
      <AlertDialog.Title
        >Apakah kamu yakin ingin menghapus barang ini?</AlertDialog.Title
      >
      <AlertDialog.Description>
        <!-- This action cannot be undone. This will permanently delete your account and remove your data from our servers. -->
      </AlertDialog.Description>
    </AlertDialog.Header>
    <AlertDialog.Footer>
      <AlertDialog.Cancel>Batal</AlertDialog.Cancel>
      <AlertDialog.Action
        onclick={onDestroy}
        class="bg-destructive hover:bg-destructive/90">Hapus</AlertDialog.Action
      >
    </AlertDialog.Footer>
  </AlertDialog.Content>
</AlertDialog.Root>
