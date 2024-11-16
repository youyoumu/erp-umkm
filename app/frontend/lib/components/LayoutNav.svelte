<script>
  import { router } from '@inertiajs/svelte'
  import NavLink from './NavLink.svelte'

  let { children } = $props()
  let page = $state(window.location.pathname)
  // window.addEventListener('popstate', () => {
  //   page = window.location.pathname
  // })
  // router.on('success', (event) => {
  //   page = event.detail.page.url
  // })

  // $inspect(page)
</script>

<main class="flex h-svh min-h-svh flex-col items-center">
  <header class=" bg-slate-900 px-4 py-4 text-white flex justify-center w-full">
    <div class="container flex justify-between">
      <div>
        <NavLink
          href="/dashboard"
          active={page.startsWith('/dashboard/') || page === '/dashboard'}
          >Mustika Bumi Saga</NavLink
        >
      </div>
      <div>
        <NavLink
          href="/items"
          active={page.startsWith('/items/') || page === '/items'}
          >Barang</NavLink
        >
        <NavLink
          href="/customers"
          active={page.startsWith('/customers/') || page === '/customers'}
          >Pembeli</NavLink
        >
        <NavLink
          href="/invoices"
          active={page.startsWith('/invoices/') || page === '/invoices'}
          >Nota</NavLink
        >
      </div>
    </div>
  </header>
  <div class="container grow">
    {@render children()}
  </div>
  <footer class="flex justify-center bg-slate-900 p-4 text-white w-full">
    Mustika Bumi Saga
  </footer>
</main>
