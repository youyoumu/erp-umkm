<script>
import { useForm } from "@inertiajs/svelte"
import { createEventDispatcher } from "svelte"

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
    <label for="cost_price">Cost price</label>
    <input
      type="number"
      name="cost_price"
      id="cost_price"
      bind:value={$form.cost_price}
      class="mt-2 block w-full rounded-md border border-gray-400 px-3 py-2 shadow outline-none"
    />
    {#if $form.errors.cost_price}
      <div class="px-3 py-2 font-medium text-red-500">
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
      class="mt-2 block w-full rounded-md border border-gray-400 px-3 py-2 shadow outline-none"
    />
    {#if $form.errors.selling_price}
      <div class="px-3 py-2 font-medium text-red-500">
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
      class="mt-2 block w-full rounded-md border border-gray-400 px-3 py-2 shadow outline-none"
    />
    {#if $form.errors.stock}
      <div class="px-3 py-2 font-medium text-red-500">
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
      class="mt-2 block w-full rounded-md border border-gray-400 px-3 py-2 shadow outline-none"
    />
    {#if $form.errors.code}
      <div class="px-3 py-2 font-medium text-red-500">
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
      class="mt-2 block w-full rounded-md border border-gray-400 px-3 py-2 shadow outline-none"
    />
    {#if $form.errors.category}
      <div class="px-3 py-2 font-medium text-red-500">
        {$form.errors.category.join(', ')}
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
