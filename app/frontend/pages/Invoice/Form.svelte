<script>
  import { useForm } from '@inertiajs/svelte'
  import { createEventDispatcher } from 'svelte'

  const dispatch = createEventDispatcher()

  export let invoice
  export let submitText

  const form = useForm({
    date: invoice.date || '',
    code: invoice.code || '',
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
      class="block shadow rounded-md border border-gray-400 outline-none px-3 py-2 mt-2 w-full"
    />
    {#if $form.errors.date}
      <div class="text-red-500 px-3 py-2 font-medium">
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
      class="block shadow rounded-md border border-gray-400 outline-none px-3 py-2 mt-2 w-full"
    />
    {#if $form.errors.code}
      <div class="text-red-500 px-3 py-2 font-medium">
        {$form.errors.code.join(', ')}
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
