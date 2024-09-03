<script>
import { useForm } from "@inertiajs/svelte"
import { createEventDispatcher } from "svelte"
import { Input } from "$lib/components/ui/input"
import Label from "$lib/components/ui/label/label.svelte"
import Errors from "$lib/components/Errors.svelte"
import FormField from "$lib/components/FormField.svelte"
import Button from "$lib/components/ui/button/button.svelte"
import Textarea from "$lib/components/ui/textarea/textarea.svelte"

const dispatch = createEventDispatcher()
export let item
export let submitText

const form = useForm({
  name: item.name || "",
  notes: item.notes || "",
  cost_price: item.cost_price || "",
  selling_price: item.selling_price || "",
  stock: item.stock || "",
  code: item.code || "",
  category: item.category || "",
})
</script>

<form class="flex flex-col gap-4 py-4" on:submit|preventDefault={dispatch('submit', { form: $form })}>
  <FormField>
    <Label for="name">Nama Barang</Label>
    <Input id="name" bind:value={$form.name} />
    <Errors errors={$form.errors.name} />
  </FormField>

  <FormField>
    <Label for="cost_price">Harga Modal</Label>
    <Input id="cost_price" bind:value={$form.cost_price} type="number" />
    <Errors errors={$form.errors.cost_price} />
  </FormField>

  <FormField>
    <Label for="selling_price">Harga Jual</Label>
    <Input id="selling_price" bind:value={$form.selling_price} type="number" />
    <Errors errors={$form.errors.selling_price} />
  </FormField>

  <FormField>
    <Label for="stock">Stok</Label>
    <Input id="stock" bind:value={$form.stock} />
    <Errors errors={$form.errors.stock} />
  </FormField>

  <FormField>
    <Label for="code">Kode Barang</Label>
    <Input id="code" bind:value={$form.code} />
    <Errors errors={$form.errors.code} />
  </FormField>

  <FormField>
    <Label for="category">Kategori</Label>
    <Input id="category" bind:value={$form.category} />
    <Errors errors={$form.errors.category} />
  </FormField>

  <FormField>
    <Label for="notes">Catatan</Label>
    <Textarea id="notes" bind:value={$form.notes} />
    <Errors errors={$form.errors.notes} />
  </FormField>

  <Button type="submit" disabled={$form.processing}>{submitText}</Button>
</form>
