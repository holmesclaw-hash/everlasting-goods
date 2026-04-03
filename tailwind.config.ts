import type { Config } from "tailwindcss";

const config: Config = {
  content: [
    "./src/pages/**/*.{js,ts,jsx,tsx,mdx}",
    "./src/components/**/*.{js,ts,jsx,tsx,mdx}",
    "./src/app/**/*.{js,ts,jsx,tsx,mdx}",
  ],
  theme: {
    extend: {
      colors: {
        forest: {
          50: '#f0f5ec',
          100: '#d8e5cf',
          200: '#b3cc9f',
          300: '#8db36f',
          400: '#5a8a2f',
          500: '#2D5016',
          600: '#254213',
          700: '#1d3410',
          800: '#15260c',
          900: '#0e1808',
        },
        cream: {
          DEFAULT: '#FAFAF5',
          100: '#F5F5EC',
          200: '#EEEED8',
        },
        brown: {
          accent: '#8B6914',
          light: '#B8941F',
          dark: '#6B5010',
        },
        charcoal: '#1a1a1a',
      },
      fontFamily: {
        serif: ['Playfair Display', 'Georgia', 'serif'],
        sans: ['Inter', 'system-ui', 'sans-serif'],
      },
      typography: {
        DEFAULT: {
          css: {
            color: '#1a1a1a',
            a: {
              color: '#2D5016',
              '&:hover': {
                color: '#254213',
              },
            },
            h1: { fontFamily: 'Playfair Display, Georgia, serif' },
            h2: { fontFamily: 'Playfair Display, Georgia, serif' },
            h3: { fontFamily: 'Playfair Display, Georgia, serif' },
            h4: { fontFamily: 'Playfair Display, Georgia, serif' },
          },
        },
      },
    },
  },
  plugins: [],
};
export default config;
