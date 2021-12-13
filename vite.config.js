import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import { resolve } from 'path'
import path from 'path'

export default defineConfig({
  plugins: [vue()],
  resolve: {
    alias: {
      process: "process/browser",
      stream: "stream-browserify",
      zlib: "browserify-zlib",
      util: "util",
      web3: path.resolve(__dirname, './node_modules/web3/dist/web3.min.js'),
      '@': resolve(__dirname, 'src'),
    },
  },
  server: {
    // open: true,
    host: true
  },
})
