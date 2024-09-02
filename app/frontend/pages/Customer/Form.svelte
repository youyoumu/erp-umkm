<script>
import { useForm } from "@inertiajs/svelte"
import { createEventDispatcher } from "svelte"

const dispatch = createEventDispatcher()

export let customer
export let submitText

const form = useForm({
  name: customer.name || "",
  notes: customer.notes || "",
  address: customer.address || "",
  contact: customer.contact || "",
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
      class="mt-2 block w-full rounded-md border border-gray-400 px-3 py-2 shadow outline-none"
    />
    {#if $form.errors.name}
      <div class="px-3 py-2 font-medium text-red-500">
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
      class="mt-2 block w-full rounded-md border border-gray-400 px-3 py-2 shadow outline-none"
    />
    {#if $form.errors.notes}
      <div class="px-3 py-2 font-medium text-red-500">
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
      class="mt-2 block w-full rounded-md border border-gray-400 px-3 py-2 shadow outline-none"
    />
    {#if $form.errors.address}
      <div class="px-3 py-2 font-medium text-red-500">
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
      class="mt-2 block w-full rounded-md border border-gray-400 px-3 py-2 shadow outline-none"
    />
    {#if $form.errors.contact}
      <div class="px-3 py-2 font-medium text-red-500">
        {$form.errors.contact.join(', ')}
      </div>
    {/if}
  </div>

  <div class="inline">
    <button
      type="submit"
      disabled={$form.processing}
      class="inline-block cursor-pointer rounded-lg bg-blue-600 px-5 py-3 font-medium text-white"
    >
      {submitText}
    </button>
  </div>
</form>
