const colors = require('tailwindcss/colors')

module.exports = {
  purge: [],
  darkMode: false, // or 'media' or 'class'
  theme: {
    colors: {
      transparent: 'transparent',
      current: 'currentColor',
      gray: colors.gray,
      red: colors.red,
      teal: colors.teal,
      white: colors.white,
      black: colors.black,
    }
  },
  variants: {
    extend: {
      backgroundColor: ['odd']
    },
  },
  plugins: [],
}
