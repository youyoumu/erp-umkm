<script>
import { useForm } from "@inertiajs/svelte"
import { createEventDispatcher } from "svelte"

const dispatch = createEventDispatcher()

export let invoice
export let submitText

const form = useForm({
  date: invoice.date || "",
  code: invoice.code || "",
})
</script>

<form
  class="contents"
  on:submit|preventDefault={dispatch('submit', { form: $form })}
>
  <div class="my-5">
    <label for="date">Date</label>
    <input
      type="datetime-local"
      name="date"
      id="date"
      bind:value={$form.date}
      class="mt-2 block w-full rounded-md border border-gray-400 px-3 py-2 shadow outline-none"
    />
    {#if $form.errors.date}
      <div class="px-3 py-2 font-medium text-red-500">
        {$form.errors.date.join(', ')}
      </div>
    {/if}
  </div>

  <div class="my-5">
    <label for="code">Code</label>
    <input
      type="text"
      name="code"
      id="code"
      bind:value={$form.code}
      class="mt-2 block w-full rounded-md border border-gray-400 px-3 py-2 shadow outline-none"
    />
    {#if $form.errors.code}
      <div class="px-3 py-2 font-medium text-red-500">
        {$form.errors.code.join(', ')}
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
