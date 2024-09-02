import { svelte } from "@sveltejs/vite-plugin-svelte"
import { defineConfig } from "vite"
import RubyPlugin from "vite-plugin-ruby"
import path from "path"

export default defineConfig({
  plugins: [svelte(), RubyPlugin()],
  resolve: {
    alias: {
      $lib: path.resolve("./app/frontend/lib"),
    },
  },
})
