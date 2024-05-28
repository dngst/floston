const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
        maxWidth: {
            '1/2': '65%',
        },
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      colors: {
        floston: '#93E9BE',
        flostontext: '#393E41',
        flostonlink: '#3F88C5'
      },
      spacing: {
        flostonpmd: '5%',
        flostonp: '1%'
      },
      zIndex: {
        '1': 1
      }
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
