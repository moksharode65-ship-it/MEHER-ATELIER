$appJsPath = "C:\Users\Pradnya Rode\OneDrive\Desktop\VS CODE\my shop\app.js"
$content = Get-Content $appJsPath -Raw -Encoding UTF8

# Replace beauty products section with clean, elegant, professional product names and descriptions
$cleanBeauty = @"
  // --- BEAUTY & COSMETICS ---
  {
    id: 'meher-3',
    asin: 'B0FPXMVJ49',
    shortUrl: 'https://link.amazon/B08n3QCMX',
    title: "LOVETC Lash Extension Volumizing Mascara (Jet Black)",
    category: 'beauty',
    categoryName: 'Eye Makeup',
    price: 600,
    originalPrice: 850,
    rating: 4.5,
    reviews: 1420,
    badge: 'Trending',
    image: 'images/catalog/catalog_3.png',
    description: 'High-definition lengthening and volumizing mascara formulated with smudge-proof polymers and a curved silicone brush for instant lash lift and all-day curl.',
    features: ['Waterproof & Smudge-Proof', 'Precision Silicone Curved Wand', 'Clump-Free Volumizing Effect', 'Easy to Remove with Warm Water'],
    sizes: ['10ml']
  },
  {
    id: 'meher-4',
    asin: 'B0CTS1NJXV',
    shortUrl: 'https://link.amazon/B08LWqwBo',
    title: "Lakmé 9 to 5 Weightless Mousse Foundation",
    category: 'beauty',
    categoryName: 'Face Foundation',
    price: 315,
    originalPrice: 700,
    rating: 4.6,
    reviews: 4210,
    badge: 'Top Pick',
    image: 'images/catalog/catalog_4.png',
    description: 'Ultra-lightweight whipped mousse foundation that blends effortlessly for a poreless, velvety matte finish with medium-to-full buildable coverage.',
    features: ['Air-Whipped Mousse Texture', 'Breathable Matte Finish', 'SPF Protected Lightweight Formula', 'Long-Wearing Oil Control'],
    sizes: ['25g']
  },
  {
    id: 'meher-5',
    asin: 'B0DWGXYW66',
    shortUrl: 'https://link.amazon/B01Zxu0vk',
    title: "Lakmé Absolute Matte Liquid Lipstick with Hyaluronic Acid",
    category: 'beauty',
    categoryName: 'Lip Makeup',
    price: 599,
    originalPrice: 799,
    rating: 4.5,
    reviews: 2980,
    badge: 'Hydrating Matte',
    image: 'images/catalog/catalog_5.png',
    description: 'Luxurious transfer-proof liquid matte lipstick infused with hydrating Hyaluronic Acid. Delivers high-impact pigment with comfortable, non-drying 16-hour wear.',
    features: ['Enriched with Hyaluronic Acid', '16-Hour Transferproof Wear', 'One-Stroke Rich Pigment', 'Velvety Non-Cracking Formula'],
    sizes: ['5.5ml']
  },
  {
    id: 'meher-6',
    asin: 'B0DP7B4BK6',
    shortUrl: 'https://link.amazon/B00vl8whI',
    title: "Coloressence Daily Glam Essentials Makeup Kit",
    category: 'beauty',
    categoryName: 'Makeup Essentials',
    price: 626,
    originalPrice: 899,
    rating: 4.4,
    reviews: 1890,
    badge: 'All-In-One Kit',
    image: 'images/catalog/catalog_6.png',
    description: 'Curated all-in-one beauty collection containing essential waterproof eyeliner, kajal, compact powder, and velvety lipstick for everyday elegance.',
    features: ['Complete Daily Essentials', 'Waterproof Formulations', 'Travel-Friendly Pack', 'Suitable for All Skin Tones'],
    sizes: ['Combo Pack']
  },
  {
    id: 'meher-7',
    asin: 'B0H29YFRSY',
    shortUrl: 'https://link.amazon/B03fJSFLt',
    title: "RENÉE Midnight 24HR Waterproof Kohl Kajal Pencil",
    category: 'beauty',
    categoryName: 'Eye Makeup',
    price: 220,
    originalPrice: 275,
    rating: 4.7,
    reviews: 6200,
    badge: 'Bestseller',
    image: 'images/catalog/catalog_7.png',
    description: 'Intense jet-black kohl pencil with an ultra-smooth glide. Enriched with Vitamin E and botanical extracts for safe, smudge-free 24-hour wear.',
    features: ['One-Swipe Intense Black Pigment', '24H Smudge & Waterproof', 'Enriched with Vitamin E', 'Safe for Sensitive Eyes & Lens Wearers'],
    sizes: ['0.35g']
  },
  {
    id: 'meher-8',
    asin: 'B0DSWJ3DX2',
    shortUrl: 'https://link.amazon/B0aWOP16j',
    title: "Dual-End Velvety Matte & Satin Cream Lipstick",
    category: 'beauty',
    categoryName: 'Lip Makeup',
    price: 499,
    originalPrice: 900,
    rating: 4.3,
    reviews: 870,
    badge: 'Dual Finish',
    image: 'images/catalog/catalog_8.png',
    description: 'Smart 2-in-1 lipstick featuring a nourishing satin cream lipstick on one end and a bold, long-lasting velvety matte finish on the other.',
    features: ['Dual Matte & Creamy Gloss Ends', 'Rich Creamy Texture', 'Non-Drying Formula', 'Compact Pocket Design'],
    sizes: ['Dual 4g']
  },
  {
    id: 'meher-14',
    asin: 'B0BVJ71QBH',
    shortUrl: 'https://link.amazon/B0hfxDM73',
    title: "Lakmé Enrich Cushion Matte Lipstick (Chocolate Nude)",
    category: 'beauty',
    categoryName: 'Lip Makeup',
    price: 396,
    originalPrice: 990,
    rating: 4.5,
    reviews: 5410,
    badge: 'Top Pick',
    image: 'images/catalog/catalog_14.png',
    description: 'Enriched with nourishing French Rose Oil, this comfortable cushion-matte bullet lipstick glides seamlessly and leaves a soft-focus velvet finish.',
    features: ['Infused with French Rose Oil', 'Feather-Soft Cushion Matte', 'Warm Indian Nude Shade', 'Smudge-Resistant Wear'],
    sizes: ['4.5g']
  },
  {
    id: 'meher-25',
    asin: 'B0DRJSKCC9',
    shortUrl: 'https://link.amazon/B0i6lCwDx',
    title: "Lakmé Skin Radiance Whipped Mousse Tint (SPF 15)",
    category: 'beauty',
    categoryName: 'Face Foundation',
    price: 314,
    originalPrice: 499,
    rating: 4.5,
    reviews: 2150,
    badge: 'Skin Loving',
    image: 'images/catalog/catalog_25.png',
    description: 'Air-light skin tint infused with antioxidants that evens skin tone with sheer-to-medium coverage, sun protection, and a fresh natural glow.',
    features: ['Enriched with Nourishing Actives', 'Non-Pore Clogging Formula', 'Natural Skin-Like Glow', 'SPF 15 Daily Sun Defense'],
    sizes: ['30g']
  },
  {
    id: 'meher-28',
    asin: 'B0DSWB2392',
    shortUrl: 'https://link.amazon/B0iDQPHqY',
    title: "Magic pH Color-Changing Hydrating Lip Glow Stain",
    category: 'beauty',
    categoryName: 'Lip Makeup',
    price: 475,
    originalPrice: 750,
    rating: 4.6,
    reviews: 4780,
    badge: 'Viral Pick',
    image: 'images/catalog/catalog_28.png',
    description: 'Innovative pH-activated lip balm that blooms into a customized, flattering rosy-pink flush upon application while providing deep hydration.',
    features: ['pH Activated Custom Pink Hue', 'Ultra-Hydrating Botanical Oils', 'Click-Pen Hygienic Dispenser', 'Waterproof 12H Tint Stain'],
    sizes: ['3.2g']
  },
  {
    id: 'meher-39',
    asin: 'B09HSPHL7M',
    shortUrl: 'https://link.amazon/B00YqlZX2',
    title: "Blue Heaven Vanilla Glam Complete Festive Makeup Vanity Box",
    category: 'beauty',
    categoryName: 'Makeup Box Set',
    price: 688,
    originalPrice: 1399,
    rating: 4.5,
    reviews: 3200,
    badge: 'Festive Kit',
    image: 'images/batch2/new_2.png',
    description: 'All-inclusive festive beauty vanity set featuring matching foundation, compact, eye palette, and long-wear lipsticks with a subtle vanilla aroma.',
    features: ['Comprehensive Complete Beauty Box', 'Subtle Vanilla Infused Scent', 'All-Skin Tone Palette', 'Festive Celebration Ready'],
    sizes: ['Complete Vanity Box']
  }
"@

# Replace the whole BEAUTY & COSMETICS section
$pattern = '(?s)// --- BEAUTY & COSMETICS ---.*?(?=\r?\n\];)'
if ($content -match $pattern) {
    $content = [regex]::Replace($content, $pattern, $cleanBeauty.Trim())
    # Also clean up perfume title if any encoding artifact exists
    $content = $content -replace 'Engage Luxury Perfume Gift Set for Women [^"]* 4 Premium Fragrances', 'Engage Luxury Perfume Gift Set for Women (Set of 4 Premium Fragrances)'
    $content | Set-Content $appJsPath -Encoding UTF8
    Write-Output "Successfully updated beauty product names and descriptions!"
} else {
    Write-Error "Could not find beauty products section"
}

