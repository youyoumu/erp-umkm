<script lang="ts">
  import { preventDefault } from 'svelte/legacy';

  import Errors from '$lib/components/Errors.svelte'
  import FormField from '$lib/components/FormField.svelte'
  import Button from '$lib/components/ui/button/button.svelte'
  import { Input } from '$lib/components/ui/input'
  import Label from '$lib/components/ui/label/label.svelte'
  import Textarea from '$lib/components/ui/textarea/textarea.svelte'
  import { useForm } from '@inertiajs/svelte'
  import { createEventDispatcher } from 'svelte'

  const dispatch = createEventDispatcher()
  let { customer, submitText } = $props();

  const form = useForm({
    name: customer.name || '',
    notes: customer.notes || '',
    address: customer.address || '',
    contact: customer.contact || '',
  })
</script>

<form
  class="flex flex-col gap-4 py-4"
  onsubmit={preventDefault(dispatch('submit', { form: $form }))}
>
  <FormField>
    <Label for="name">Nama Pembeli</Label>
    <Input
      id="name"
      bind:value={$form.name}
      placeholder="Masukkan Nama Pembeli"
    />
    <Errors errors={$form.errors.name} />
  </FormField>
  <FormField>
    <Label for="contact">Kontak</Label>
    <Input id="contact" bind:value={$form.contact} />
    <Errors errors={$form.errors.contact} />
  </FormField>
  <FormField>
    <Label for="address">Alamat</Label>
    <Textarea id="address" bind:value={$form.address} />
    <Errors errors={$form.errors.address} />
  </FormField>
  <FormField>
    <Label for="notes">Catatan</Label>
    <Textarea
      id="notes"
      bind:value={$form.notes}
      placeholder="Kerabat, tukang, relasi, dll"
    />
    <Errors errors={$form.errors.notes} />
  </FormField>

  <Button type="submit" disabled={$form.processing}>{submitText}</Button>
</form>
