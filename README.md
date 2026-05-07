# Cam Tablo Creator

AI-powered **tempered glass wall art** ("cam tablo") mockup generator for Etsy listings.

Upload a flat 1×1 (or any aspect ratio) artwork — the app generates a series of glass-wall-art lifestyle mockups (living room, kitchen, bedroom, hallway, etc.), plus Etsy SEO title, description, and 13 tags, all locked to a glass wall art product type.

## Features

- **Glass wall art only** — outputs are frameless tempered glass panels mounted on real interior walls (no canvas, no poster, no apparel)
- **Aspect ratio lock** — the panel rectangle in every mockup matches the input artwork's width:height exactly
- **Varied compositions** — wide / medium / close-up / three-quarter / low-angle / room vignette per mockup
- **Etsy lifestyle aesthetic** — scandi / japandi / boho / mid-century / organic-modern / industrial-modern room styles, warm natural lighting, curated decor
- **Two presets**: 10-piece (3 living room + 2 kitchen + 1 bedroom + 1 dining + 3 lifestyle) and 20-piece (full slot coverage)
- **Glass-wall-art SEO** — title, description, and tags hard-locked to wall art / home decor terms; apparel words filtered out

## Setup

```bash
npm install
cp config.example.json config.json
# edit config.json: set operaPath / chromePath if needed
echo "OPENROUTER_API_KEY=sk-or-v1-..." > .env
npm run start:dist
```

Open <http://localhost:3001>.

## Requirements

- Node.js 18+
- An OpenRouter account with credits (image generation uses `google/gemini-2.5-flash-image`)
- Opera GX or Chrome (for CDP-based Etsy upload — optional)

## Stack

- Express 5, Multer, Sharp
- OpenRouter (Gemini 2.5 Flash Image for mockups, Llama 4 Maverick for tags/title)
- Playwright (Etsy / EtsyHunt automation)
- esbuild (bundles `server.js` + `create.js` into `dist/`)

## License

MIT — see source files. The bundled `dist/` includes glass-wall-art-locked prompts; modify at your own risk.
