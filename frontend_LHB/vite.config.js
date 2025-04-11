import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import tailwindcss from '@tailwindcss/vite'

export default defineConfig({
  plugins: [react(), tailwindcss()],
  server: {
    host: '172.27.16.252', // Allow access via this IP
    port: 5174,             // You can change the port if needed
    proxy: {
      '/api': {
        target: 'http://172.27.16.252:8000', // Django backend
        changeOrigin: true,
        secure: false,
      },
    },
  },
});
