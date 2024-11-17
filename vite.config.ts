import { svelte } from '@sveltejs/vite-plugin-svelte'
import path from 'path'
import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'

export default defineConfig({
  plugins: [svelte(), RubyPlugin()],
  resolve: {
    alias: {
      $lib: path.resolve('./app/frontend/lib'),
      $types: path.resolve('./app/frontend/types'),
    },
  },
})
