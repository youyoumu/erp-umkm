<script lang="ts">
  import { Table } from 'lucide-svelte'

  import * as AlertDialog from '$lib/components/ui/alert-dialog/index.js'
  import { Button } from '$lib/components/ui/button'
</script>

<AlertDialog.Root>
  <AlertDialog.Trigger
    ><Button variant="secondary">
      <Table size="20" />
      Export CSV</Button
    ></AlertDialog.Trigger
  >
  <AlertDialog.Content>
    <AlertDialog.Header>
      <AlertDialog.Title>Export CSV?</AlertDialog.Title>
      <AlertDialog.Description></AlertDialog.Description>
    </AlertDialog.Header>
    <AlertDialog.Footer>
      <AlertDialog.Cancel>Batal</AlertDialog.Cancel>
      <AlertDialog.Action>Export</AlertDialog.Action>
    </AlertDialog.Footer>
  </AlertDialog.Content>
</AlertDialog.Root>
