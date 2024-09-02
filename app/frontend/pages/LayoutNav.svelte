<script>
import { inertia, router } from "@inertiajs/svelte"
import NavLink from "./NavLink.svelte"
let page = window.location.pathname
window.addEventListener("popstate", () => {
  page = window.location.pathname
})
router.on("success", (event) => {
  page = event.detail.page.url
})
</script>

<main class="flex min-h-svh flex-col">
  <header class=" bg-slate-900 px-4 py-4 text-white">
    <div class="container flex justify-between">
      <div>
        <NavLink href="/dashboard" active={page.startsWith("/dashboard/") || page === "/dashboard"}>Mustika Bumi Saga</NavLink>
      </div>
      <div>
        <NavLink href="/items" active={page.startsWith("/items/") || page === "/items"}>Barang</NavLink>
        <NavLink href="/customers" active={page.startsWith("/customers/") || page === "/customers"}>Pembeli</NavLink>
        <NavLink href="/invoices" active={page.startsWith("/invoices/") || page === "/invoices"}>Nota</NavLink>
      </div>
    </div>
  </header>
  <div class="container grow">
    <slot />
  </div>
  <footer class="flex justify-center bg-slate-900 p-4 text-white">Mustika Bumi Saga</footer>
</main>
