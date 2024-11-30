<script>
  import { page } from '@inertiajs/svelte'

  import NavLink from './NavLink.svelte'

  let { children } = $props()
  const url = $derived($page.url)
</script>

<main class="flex h-svh min-h-svh flex-col items-center">
  <header class=" bg-primary px-4 py-4 text-white flex justify-center w-full">
    <div class="container flex justify-between">
      <div>
        <NavLink
          href="/dashboard"
          active={url.startsWith('/dashboard/') || url === '/dashboard'}
          >Mustika Bumi Saga</NavLink
        >
      </div>
      <div>
        <NavLink
          href="/items"
          active={url.startsWith('/items/') || url === '/items'}>Barang</NavLink
        >
        <NavLink
          href="/customers"
          active={url.startsWith('/customers/') || url === '/customers'}
          >Pembeli</NavLink
        >
        <NavLink
          href="/invoices"
          active={url.startsWith('/invoices/') || url === '/invoices'}
          >Nota</NavLink
        >
      </div>
    </div>
  </header>
  <div class="container grow">
    {@render children()}
  </div>
  <footer class="flex justify-center bg-primary p-4 text-white w-full">
    Mustika Bumi Saga
  </footer>
</main>
