module.exports = {
  mode: "jit",
  content: [
    "./src/**/*.{html,js,svelte,ts}",
    "./node_modules/tw-elements/dist/js/**/*.js"
  ],
  theme: {
    extend: {
      fontFamily: ['-apple-system', 'BlinkMacSystemFont', 'Segoe UI', 'Roboto', 'Oxygen', 'Ubuntu', 'Cantarell', 'Open Sans', 'Helvetica Neue', 'sans-serif']
    },
  },
  plugins: [require("tw-elements/dist/plugin.cjs")],
  darkMode: "class"
};