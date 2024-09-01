<script>
  import { useForm } from '@inertiajs/svelte'
  import { createEventDispatcher } from 'svelte'

  const dispatch = createEventDispatcher()

  export let customer
  export let submitText

  const form = useForm({
    name: customer.name || '',
    notes: customer.notes || '',
    address: customer.address || '',
    contact: customer.contact || '',
  })
</script>

<form
  class="contents"
  on:submit|preventDefault={dispatch('submit', { form: $form })}
>
  <div class="my-5">
    <label for="name">Name</label>
    <input
      type="text"
      name="name"
      id="name"
      bind:value={$form.name}
      class="block shadow rounded-md border border-gray-400 outline-none px-3 py-2 mt-2 w-full"
    />
    {#if $form.errors.name}
      <div class="text-red-500 px-3 py-2 font-medium">
        {$form.errors.name.join(', ')}
      </div>
    {/if}
  </div>

  <div class="my-5">
    <label for="note">Notes</label>
    <textarea
      name="note"
      id="note"
      bind:value={$form.notes}
      rows="4"
      class="block shadow rounded-md border border-gray-400 outline-none px-3 py-2 mt-2 w-full"
    />
    {#if $form.errors.notes}
      <div class="text-red-500 px-3 py-2 font-medium">
        {$form.errors.notes.join(', ')}
      </div>
    {/if}
  </div>

  <div class="my-5">
    <label for="address">Address</label>
    <input
      type="text"
      name="address"
      id="address"
      bind:value={$form.address}
      class="block shadow rounded-md border border-gray-400 outline-none px-3 py-2 mt-2 w-full"
    />
    {#if $form.errors.address}
      <div class="text-red-500 px-3 py-2 font-medium">
        {$form.errors.address.join(', ')}
      </div>
    {/if}
  </div>

  <div class="my-5">
    <label for="contact">Contact</label>
    <input
      type="text"
      name="contact"
      id="contact"
      bind:value={$form.contact}
      class="block shadow rounded-md border border-gray-400 outline-none px-3 py-2 mt-2 w-full"
    />
    {#if $form.errors.contact}
      <div class="text-red-500 px-3 py-2 font-medium">
        {$form.errors.contact.join(', ')}
      </div>
    {/if}
  </div>

 <div class="inline">
    <button
      type="submit"
      disabled={$form.processing}
      class="rounded-lg py-3 px-5 bg-blue-600 text-white inline-block font-medium cursor-pointer"
    >
      {submitText}
    </button>
  </div>
</form>
