<script>
  import { useForm } from '@inertiajs/svelte'
  import { createEventDispatcher } from 'svelte'

  const dispatch = createEventDispatcher()

  export let item
  export let submitText

  const form = useForm({
    name: item.name || '',
    notes: item.notes || '',
    cost_price: item.cost_price || '',
    selling_price: item.selling_price || '',
    stock: item.stock || '',
    code: item.code || '',
    category: item.category || '',
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
    <label for="cost_price">Cost price</label>
    <input
      type="number"
      name="cost_price"
      id="cost_price"
      bind:value={$form.cost_price}
      class="block shadow rounded-md border border-gray-400 outline-none px-3 py-2 mt-2 w-full"
    />
    {#if $form.errors.cost_price}
      <div class="text-red-500 px-3 py-2 font-medium">
        {$form.errors.cost_price.join(', ')}
      </div>
    {/if}
  </div>

  <div class="my-5">
    <label for="selling_price">Selling price</label>
    <input
      type="number"
      name="selling_price"
      id="selling_price"
      bind:value={$form.selling_price}
      class="block shadow rounded-md border border-gray-400 outline-none px-3 py-2 mt-2 w-full"
    />
    {#if $form.errors.selling_price}
      <div class="text-red-500 px-3 py-2 font-medium">
        {$form.errors.selling_price.join(', ')}
      </div>
    {/if}
  </div>

  <div class="my-5">
    <label for="stock">Stock</label>
    <input
      type="text"
      name="stock"
      id="stock"
      bind:value={$form.stock}
      class="block shadow rounded-md border border-gray-400 outline-none px-3 py-2 mt-2 w-full"
    />
    {#if $form.errors.stock}
      <div class="text-red-500 px-3 py-2 font-medium">
        {$form.errors.stock.join(', ')}
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

  <div class="my-5">
    <label for="category">Category</label>
    <input
      type="text"
      name="category"
      id="category"
      bind:value={$form.category}
      class="block shadow rounded-md border border-gray-400 outline-none px-3 py-2 mt-2 w-full"
    />
    {#if $form.errors.category}
      <div class="text-red-500 px-3 py-2 font-medium">
        {$form.errors.category.join(', ')}
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
