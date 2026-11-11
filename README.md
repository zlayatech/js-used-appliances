# JS Used Appliances website

One-page website for JS Used Appliances, 2425 Hyde Park Blvd, Suite 2, Niagara Falls, NY 14305.
Plain HTML and CSS with a little inline JavaScript. No build step, hosted on GitHub Pages.

Live: https://jsusedappliances.com/ (custom domain, set by the `CNAME` file; the old
https://zlayatech.github.io/js-used-appliances/ address redirects there).

## What's where

| Path | What it is |
| --- | --- |
| `index.html` | The whole site: content, CSS, structured data (LocalBusiness + FAQ) and the open/closed script |
| `404.html` | Page shown for broken links |
| `assets/img/` | Responsive AVIF + JPEG images (logo and store photos) |
| `assets/fonts/` | Archivo variable font, self-hosted |
| `og-image.jpg` | Preview image shown when the link is shared on Facebook, texts, etc. |
| `favicon-32.png`, `apple-touch-icon.png`, `icon-*.png` | Browser and home-screen icons |
| `robots.txt`, `sitemap.xml`, `site.webmanifest` | Search engine and browser files |
| `CNAME` | Tells GitHub Pages to serve the site at jsusedappliances.com |
| `tools/` | Scripts and templates to regenerate the images (not part of the page) |

## Common edits

- **Hours**: change them in four places in `index.html`: the `HOURS` table in the script at the bottom, the hours
  table in the Contact section, the FAQ answer (visible text and the matching `FAQPage` JSON-LD), and
  `openingHoursSpecification` in the JSON-LD. Also update the footer.
- **Phone or email**: search and replace `716) 425-3622` / `+17164253622` / `jsusedappliances817@gmail.com`.
- **Google rating in the hero** ("5.0 on Google (26 reviews)", checked Nov 10, 2026): update it when the review count changes.
- **Delivery wording**: the "Delivery available" point and FAQ answer are based on a customer review. Confirm with the owner.

## Images

Originals live in `_source/` (not committed). To rebuild everything in `assets/img/`:

```sh
tools/build-images.sh
```

`og-image.jpg` and the icons are rendered from `tools/og-image.html` and `tools/icon.html`
(`icon.html` = tight crop for the 32px favicon, `icon.html?full` = whole emblem for the larger icons).
Serve the folder locally (`python3 -m http.server`), screenshot the 1200x630 / 512x512 box, and resize with `sips`.

## Google links

- Place ID: `ChIJWUImFsdd04kRIheGfQHoljs`
- Write a review: https://search.google.com/local/writereview?placeid=ChIJWUImFsdd04kRIheGfQHoljs
- Read reviews: https://www.google.com/search?q=JS+Used+Appliances+Niagara+Falls+NY&ludocid=4293874387842897698#lrd=0x89d35dc716264259:0x3b96e8017d861722,1,,,

## Domain setup (jsusedappliances.com)

DNS records at the domain's DNS host:

| Type | Name | Value |
| --- | --- | --- |
| A | `@` | `185.199.108.153` |
| A | `@` | `185.199.109.153` |
| A | `@` | `185.199.110.153` |
| A | `@` | `185.199.111.153` |
| CNAME | `www` | `zlayatech.github.io` |

GitHub then serves the site at `https://jsusedappliances.com/` and redirects `www.` to it.
After DNS resolves, tick **Enforce HTTPS** in Settings > Pages.

## SEO checklist after launch

1. In the Google Business Profile, set the website to https://jsusedappliances.com/ (it currently points to Facebook).
2. Add a Domain property for jsusedappliances.com in Google Search Console and submit `https://jsusedappliances.com/sitemap.xml`.
3. Keep the business name, address and phone identical everywhere (site, Google, Facebook, Yelp, Nextdoor).
