/**
 * Meher Atelier — Amazon Associates Ethnic Wear & Kurti Store Logic
 * Dynamic catalog, live Amazon Associate shortlink builder, search, filtering, and wishlist
 * Mobile & Laptop Responsive Application Logic
 */

// Configuration: Default Amazon India Associate tag from MEHER collection
let config = {
  amazonTag: 'moksharode073-21',
  amazonDomain: 'amazon.in',
};


const products = [
  {
    id: 'meher-1',
    asin: 'B0GGJDMS4X',
    shortUrl: 'https://link.amazon/B0i84birr',
    title: "KLOSIA Women's Viscose Rayon Printed Sleeveless Kurta with Palazzo Set",
    category: 'palazzo',
    categoryName: 'Kurta Palazzo Set',
    price: 699,
    originalPrice: 1999,
    rating: 4.4,
    reviews: 1240,
    badge: 'Bestseller',
    image: 'images/image1.png',
    description: 'Stay breezy and stylish with this KLOSIA sleeveless printed kurti and matching palazzo set crafted from ultra-soft skin-friendly viscose rayon fabric. Features geometric and floral border prints for effortless daytime elegance.',
    features: ['100% Breathable Viscose', 'Sleeveless Round Neck', 'Flared Wide-Leg Palazzo', 'Skin-Friendly Colorfast Dye'],
    sizes: ['S', 'M', 'L', 'XL', '2XL']
  },
  {
    id: 'meher-2',
    asin: 'B0GLGGXDVK',
    shortUrl: 'https://link.amazon/B04vgTJR2',
    title: "Amayra Women's Pure Cotton Printed Kurta with Palazzo and Dupatta Set",
    category: 'suits',
    categoryName: 'Cotton Suit 3-Piece',
    price: 799,
    originalPrice: 2499,
    rating: 4.5,
    reviews: 2180,
    badge: 'Top Pick',
    image: 'images/image2.png',
    description: 'A graceful 3-piece pure cotton ensemble featuring an intricate floral print straight kurta, comfortable elasticated palazzo trousers, and a lightweight matching printed dupatta.',
    features: ['100% Pure Cotton', 'Complete 3-Piece Set', 'Calf Length Straight Cut', 'Breathable Summer Fabric'],
    sizes: ['M', 'L', 'XL', '2XL', '3XL']
  },
  {
    id: 'meher-3',
    asin: 'B0HFZRWHGV',
    shortUrl: 'https://link.amazon/B021LT5yj',
    title: "KLOSIA Women's Printed Sleeveless Straight Kurta with Matching Pants",
    category: 'palazzo',
    categoryName: 'Kurta & Pant Set',
    price: 499,
    originalPrice: 1699,
    rating: 4.3,
    reviews: 940,
    badge: 'Trending',
    image: 'images/image3.png',
    description: 'Sleek contemporary sleeveless straight kurti paired with tailored matching trousers in an earthy terracotta palette. Designed for daily comfort, casual work meetings, and college wear.',
    features: ['Premium Viscose Blend', 'Sleeveless Contemporary Cut', 'Side Slit Straight Silhouette', 'Machine Washable Gentle'],
    sizes: ['S', 'M', 'L', 'XL', 'XXL']
  },
  {
    id: 'meher-4',
    asin: 'B0GNMQTXR1',
    shortUrl: 'https://link.amazon/B0fD8POWy',
    title: "ANNI Designer Women's Viscose Blend Printed Short Kurti (NABILA RED)",
    category: 'short-kurti',
    categoryName: 'Short Kurti & Tunic',
    price: 299,
    originalPrice: 999,
    rating: 4.6,
    reviews: 3450,
    badge: 'Bestseller',
    image: 'images/image4.png',
    description: 'Vibrant NABILA RED short printed kurti crafted with a stylish square neckline and full sleeves. Pairs effortlessly with classic blue denim jeans, formal trousers, or white leggings.',
    features: ['Square Neckline', 'Full Sleeve Coverage', 'All-Day Breathable Viscose', 'Pairs with Jeans or Jeggings'],
    sizes: ['S', 'M', 'L', 'XL', 'XXL']
  },
  {
    id: 'meher-5',
    asin: 'B0H327JHZN',
    shortUrl: 'https://link.amazon/B0hQSWgky',
    title: "SONISHA Women's Stylish Floral Printed 3/4 Sleeve Flared Kurti",
    category: 'short-kurti',
    categoryName: 'Casual Floral Kurti',
    price: 399,
    originalPrice: 1299,
    rating: 4.4,
    reviews: 810,
    badge: 'Popular',
    image: 'images/image5.png',
    description: 'Charming botanical floral pattern with an empire silhouette and 3/4 sleeves. Tailored to flatter every figure with fluid motion and lightweight breathable drape.',
    features: ['Floral Motif Print', '3/4 Sleeve Style', 'Comfortable Relaxed Fit', 'Soft Hand Feel'],
    sizes: ['M', 'L', 'XL', 'XXL']
  },
  {
    id: 'meher-6',
    asin: 'B0HFZMMVWW',
    shortUrl: 'https://link.amazon/B0cVS7pU9',
    title: "KLOSIA Women's Traditional Off-White Straight Kurta with Wide-Leg Pants",
    category: 'palazzo',
    categoryName: 'Ethnic Co-ord Set',
    price: 649,
    originalPrice: 1999,
    rating: 4.5,
    reviews: 1120,
    badge: 'Prime',
    image: 'images/image6.png',
    description: 'Elegant ivory off-white straight-cut kurta paired with wide-leg relaxed palazzo pants. Accented with subtle ethnic prints suitable for family gatherings, festive days, or office wear.',
    features: ['Graceful Off-White Palette', 'Flattering Calf-Length Cut', 'Wide-Leg Flowy Bottoms', 'Shrink-Resistant Fabric'],
    sizes: ['S', 'M', 'L', 'XL', '2XL']
  },
  {
    id: 'meher-7',
    asin: 'B0HKSJ82QX',
    shortUrl: 'https://link.amazon/B07ETKgKM',
    title: "ANNI DESIGNER Farshi Salwar Suit for Women (FELICY Cream 3-Piece Set)",
    category: 'farshi-suits',
    categoryName: 'Farshi Salwar Suit',
    price: 779,
    originalPrice: 2599,
    rating: 4.6,
    reviews: 1680,
    badge: 'Festive Pick',
    image: 'images/image7.png',
    description: 'Exquisite 3-piece Farshi Salwar Suit in cream featuring a straight printed viscose kurta, voluminous traditional Farshi salwar bottoms, and an ornate matching dupatta.',
    features: ['Royal Farshi Salwar Silhouette', 'Complete 3-Piece Outfit', 'Lustrous Viscose Blend', 'Festive & Wedding Ready'],
    sizes: ['M', 'L', 'XL', 'XXL', '3XL']
  },
  {
    id: 'meher-8',
    asin: 'B0HLSRQLRD',
    shortUrl: 'https://link.amazon/B00NB5iKb',
    title: "Yogesh Craft Women's Cotton Embroidered Anarkali Kurti with Pant & Dupatta",
    category: 'anarkali',
    categoryName: 'Embroidered Anarkali Set',
    price: 1499,
    originalPrice: 3999,
    rating: 4.8,
    reviews: 2840,
    badge: 'Top Rated',
    image: 'images/image8.png',
    description: 'Dramatic jet black floor-length flared Anarkali embellished with fine gold and silver thread embroidery across the yoke and borders. Comes with matching tailored pants and an embroidered sheer dupatta.',
    features: ['Heavy Yoke Embroidery', 'Flared Anarkali Silhouette', '100% Combed Cotton Base', 'Statement Wedding/Party Ensemble'],
    sizes: ['M', 'L', 'XL', 'XXL']
  },
  {
    id: 'meher-9',
    asin: 'B0HB423MD7',
    shortUrl: 'https://link.amazon/B0aOrEC9L',
    title: "ANNI DESIGNER Farshi Salwar Suit for Women (THULASI White 3-Piece Set)",
    category: 'farshi-suits',
    categoryName: 'Farshi Salwar Suit',
    price: 747,
    originalPrice: 2499,
    rating: 4.5,
    reviews: 1390,
    badge: 'Trending',
    image: 'images/image9.png',
    description: 'Pristine white ethnic 3-piece set featuring botanical sprig prints on a straight kurta, flared Farshi salwar, and a lightweight printed dupatta. Delicate, regal, and comfortable.',
    features: ['Pristine White Aesthetic', 'Traditional Farshi Cut', 'Lightweight Printed Dupatta', 'Skin-Friendly Soft Weave'],
    sizes: ['M', 'L', 'XL', 'XXL', '4XL']
  },
  {
    id: 'meher-10',
    asin: 'B0H9M738J6',
    shortUrl: 'https://link.amazon/B05rz10EP',
    title: "ANNI DESIGNER Straight Floral Kurta with Farshi Salwar (TRIDHARA Blue)",
    category: 'farshi-suits',
    categoryName: 'Farshi Salwar Suit',
    price: 769,
    originalPrice: 2499,
    rating: 4.4,
    reviews: 950,
    badge: 'Popular',
    image: 'images/image10.png',
    description: 'Royal indigo blue straight kurta with authentic Farshi salwar pants and coordinating dupatta. Decorated with intricate traditional Jaipuri-inspired floral motifs.',
    features: ['Deep Indigo Blue Shade', 'Authentic Jaipuri Prints', 'Flared Farshi Trouser', 'Fade-Resistant Colors'],
    sizes: ['S', 'M', 'L', 'XL', 'XXL']
  },
  {
    id: 'meher-11',
    asin: 'B0H4RTXXHX',
    shortUrl: 'https://link.amazon/B0is6WVfD',
    title: "ANNI DESIGNER Embroidered Straight Kurta with Salwar (SAWINI Purple)",
    category: 'suits',
    categoryName: 'Embroidered Suit Set',
    price: 799,
    originalPrice: 2699,
    rating: 4.6,
    reviews: 1470,
    badge: 'Bestseller',
    image: 'images/image11.png',
    description: 'Rich jewel-tone royal purple kurta set highlighted by delicate thread embroidery on the neckline, accompanied by a matching flared bottom and organza-accented dupatta.',
    features: ['Rich Royal Purple Hue', 'Neckline Threadwork Embroidery', 'Coordinating Dupatta Included', 'Comfortable Festive Fit'],
    sizes: ['M', 'L', 'XL', 'XXL', '3XL']
  },
  {
    id: 'meher-12',
    asin: 'B0HJ8H49YW',
    shortUrl: 'https://link.amazon/B0b54Pb5A',
    title: "ANNI DESIGNER Festive Wedding Wear Cotton Straight Kurta Set with Dupatta",
    category: 'suits',
    categoryName: 'Wedding Festive Set',
    price: 948,
    originalPrice: 2999,
    rating: 4.7,
    reviews: 1820,
    badge: 'Top Pick',
    image: 'images/image12.png',
    description: 'A luxurious festive cotton suit ensemble featuring warm golden and beige floral tones with fine embroidery work. Ideal for weddings, puja celebrations, and festive parties.',
    features: ['Festive Golden & Pastel Hues', 'Intricate Zari/Thread Highlights', 'Full Length Matching Dupatta', 'Breathable Combed Fabric'],
    sizes: ['S', 'M', 'L', 'XL', 'XXL']
  },
  {
    id: 'meher-13',
    asin: 'B0HD7JP25P',
    shortUrl: 'https://link.amazon/B02YmvMKX',
    title: "ANNI DESIGNER Farshi Salwar Suit with Embroidered Kurta (Vallari Pink)",
    category: 'farshi-suits',
    categoryName: 'Farshi Salwar Suit',
    price: 739,
    originalPrice: 2399,
    rating: 4.5,
    reviews: 1260,
    badge: 'Trending',
    image: 'images/image13.png',
    description: 'Soft blossom pink embroidered straight kurta paired with Farshi flared salwar and a diaphanous dupatta. Subtle sheen and charming floral detail make it a head-turner.',
    features: ['Blossom Pink Pastel Hue', 'Embroidered Chest Placket', 'Flowy Farshi Salwar Cut', 'Light & Feather-Soft Fabric'],
    sizes: ['M', 'L', 'XL', 'XXL']
  },
  {
    id: 'meher-14',
    asin: 'B0HGTDRM9J',
    shortUrl: 'https://link.amazon/B03vuoJXu',
    title: "PIDAVLIYAS Women's Pure Cotton Traditional Printed Kurta Set (Mustard)",
    category: 'suits',
    categoryName: 'Pure Cotton 3-Piece',
    price: 699,
    originalPrice: 2199,
    rating: 4.6,
    reviews: 1530,
    badge: 'Haldi Special',
    image: 'images/image14.png',
    description: 'Festive mustard yellow 100% pure cotton kurta set with ethnic bandhani-inspired prints, tailored trousers, and matching printed dupatta. Ideal for Haldi rituals and traditional ceremonies.',
    features: ['100% Pure Breathable Cotton', 'Festive Mustard Yellow', 'Bandhani Traditional Motifs', 'Comfort Elastic Waistband'],
    sizes: ['S', 'M', 'L', 'XL', 'XXL']
  }
];

// State
let wishlist = JSON.parse(localStorage.getItem('curate_wishlist')) || [];
let currentCategory = 'all';
let searchQuery = '';
let currentSort = 'featured';

/**
 * Format currency in Indian Rupees
 */
function formatPrice(amount) {
  return `₹${amount.toLocaleString('en-IN')}`;
}

/**
 * Build Amazon tracking URL
 */
function buildAmazonUrl(asin, title = '', shortUrl = '') {
  if (shortUrl) {
    return shortUrl;
  }
  const domain = config.amazonDomain || 'amazon.in';
  if (asin) {
    return `https://www.${domain}/dp/${asin}?tag=${encodeURIComponent(config.amazonTag)}&linkCode=ll1`;
  }
  return `https://www.${domain}/s?k=${encodeURIComponent(title)}&tag=${encodeURIComponent(config.amazonTag)}`;
}

/**
 * Render all product cards into grid (Optimized for Mobile App 2-Column + Desktop)
 */
function renderProducts() {
  const grid = document.getElementById('productGrid');
  if (!grid) return;

  // Filter products
  let filtered = products.filter(p => {
    const matchCat = (currentCategory === 'all' || p.category === currentCategory);
    const matchSearch = p.title.toLowerCase().includes(searchQuery.toLowerCase()) ||
                        p.categoryName.toLowerCase().includes(searchQuery.toLowerCase()) ||
                        p.description.toLowerCase().includes(searchQuery.toLowerCase());
    return matchCat && matchSearch;
  });

  // Sort
  if (currentSort === 'price-low') {
    filtered.sort((a, b) => a.price - b.price);
  } else if (currentSort === 'price-high') {
    filtered.sort((a, b) => b.price - a.price);
  } else if (currentSort === 'rating') {
    filtered.sort((a, b) => b.rating - a.rating);
  }

  // Count indicator
  const resultsCounter = document.getElementById('resultsCount');
  if (resultsCounter) {
    resultsCounter.textContent = `${filtered.length} styles found`;
  }

  if (filtered.length === 0) {
    grid.innerHTML = `
      <div style="grid-column: 1 / -1; text-align: center; padding: 50px 16px;">
        <h3 style="font-size: 1.3rem; color: var(--text-muted); margin-bottom: 8px;">No matching ethnic styles found</h3>
        <p style="color: var(--text-light); margin-bottom: 18px; font-size: 0.9rem;">Try searching for a different keyword like "kurti", "farshi", or "cotton".</p>
        <button class="pill-btn active" onclick="resetFilters()">View All Collections</button>
      </div>
    `;
    return;
  }

  grid.innerHTML = filtered.map(item => {
    const isWishlisted = wishlist.includes(item.id);
    const affiliateUrl = buildAmazonUrl(item.asin, item.title, item.shortUrl);
    const discount = Math.round(((item.originalPrice - item.price) / item.originalPrice) * 100);

    return `
      <article class="product-card" data-id="${item.id}">
        <div class="product-thumb-wrap" onclick="openProductModal('${item.id}')">
          <img src="${item.image}" alt="${item.title}" loading="lazy" />
          
          <div class="product-badges">
            ${item.badge ? `<span class="badge-tag badge-${item.badge.toLowerCase().replace(/\s+/g, '-')}">${item.badge}</span>` : ''}
            ${discount > 0 ? `<span class="badge-tag badge-discount">-${discount}%</span>` : ''}
          </div>

          <div class="quick-actions" onclick="event.stopPropagation()">
            <button class="icon-btn-round ${isWishlisted ? 'favorited' : ''}" 
                    title="Add to Wishlist" 
                    aria-label="Add to Wishlist"
                    onclick="toggleWishlist('${item.id}')">
              <svg width="18" height="18" viewBox="0 0 24 24" fill="${isWishlisted ? 'currentColor' : 'none'}" stroke="currentColor" stroke-width="2">
                <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path>
              </svg>
            </button>
            <button class="icon-btn-round btn-quick-view-desk" 
                    title="Quick View" 
                    aria-label="Quick View"
                    onclick="openProductModal('${item.id}')">
              <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8z"></path>
                <circle cx="12" cy="12" r="3"></circle>
              </svg>
            </button>
          </div>
        </div>

        <div class="product-details">
          <span class="product-category-meta">${item.categoryName}</span>
          <h3 class="product-title" onclick="openProductModal('${item.id}')" title="${item.title}">${item.title}</h3>
          
          <div class="rating-row">
            <span class="stars">★</span>
            <span class="reviews-count">${item.rating} (${item.reviews.toLocaleString()})</span>
          </div>

          <div class="features-chips">
            ${item.features.slice(0, 2).map(f => `<span class="chip">${f}</span>`).join('')}
          </div>

          <div class="price-row">
            <span class="current-price">${formatPrice(item.price)}</span>
            <span class="original-price">${formatPrice(item.originalPrice)}</span>
            <span class="discount-tag">Save ${formatPrice(item.originalPrice - item.price)}</span>
          </div>

          <a href="${affiliateUrl}" 
             target="_blank" 
             rel="sponsored noopener noreferrer" 
             class="btn-amazon-buy"
             title="Order directly on Amazon India with fast Prime delivery">
            <svg viewBox="0 0 24 24" fill="currentColor">
              <path d="M15.42 13.56c-.32-.23-.74-.23-1.06 0l-3.36 2.45-1.57-1.15a.89.89 0 0 0-1.06 0l-2.09 1.53c-.32.23-.42.66-.23 1 .19.34.62.48.97.28l1.59-1.16 1.57 1.15c.32.23.74.23 1.06 0l3.88-2.83c.32-.23.42-.66.23-1a.78.78 0 0 0-.93-.27zM21.71 16.29c-1.35 1.54-3.4 2.68-5.69 2.68-3.07 0-5.83-2.05-6.72-4.99-.09-.3-.41-.47-.72-.38-.3.09-.47.41-.38.72 1.05 3.47 4.3 5.88 7.92 5.88 2.7 0 5.12-1.34 6.7-3.15.22-.25.19-.63-.06-.85a.61.61 0 0 0-.85.09z"/>
              <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.41 0-8-3.59-8-8s3.59-8 8-8 8 3.59 8 8-3.59 8-8 8z"/>
            </svg>
            <span>Buy on Amazon</span>
          </a>
        </div>
      </article>
    `;
  }).join('');
}

/**
 * Filter by Category (synchronized across desktop nav, mobile drawer, and chips)
 */
function setCategory(cat, element) {
  currentCategory = cat;
  
  // Update category pills
  document.querySelectorAll('.pill-btn').forEach(btn => btn.classList.remove('active'));
  const pill = document.querySelector(`.pill-btn[onclick*="'${cat}'"]`);
  if (pill) {
    pill.classList.add('active');
    pill.scrollIntoView({ behavior: 'smooth', inline: 'center', block: 'nearest' });
  }

  // Update desktop nav
  document.querySelectorAll('.nav-links a').forEach(a => a.classList.remove('active'));
  const navLink = document.querySelector(`.nav-links a[onclick*="'${cat}'"]`);
  if (navLink) navLink.classList.add('active');

  // Update mobile drawer links
  document.querySelectorAll('.mobile-nav-item').forEach(a => a.classList.remove('active'));
  const mobileLink = document.querySelector(`.mobile-nav-item[onclick*="'${cat}'"]`);
  if (mobileLink) mobileLink.classList.add('active');

  if (element && element.classList.contains('pill-btn')) {
    element.classList.add('active');
  }

  renderProducts();
}


function resetFilters() {
  currentCategory = 'all';
  searchQuery = '';
  const searchInput = document.getElementById('searchInput');
  if (searchInput) searchInput.value = '';
  setCategory('all');
}

/**
 * Quick View Product Detail Modal (Responsive Dialog on Laptop, Bottom-Sheet on Mobile)
 */
function openProductModal(productId) {
  const item = products.find(p => p.id === productId);
  if (!item) return;

  const modal = document.getElementById('productDetailModal');
  const modalContent = document.getElementById('productDetailContent');
  const affUrl = buildAmazonUrl(item.asin, item.title, item.shortUrl);
  const discount = Math.round(((item.originalPrice - item.price) / item.originalPrice) * 100);

  modalContent.innerHTML = `
    <div class="product-modal-dialog">
      <div class="modal-mobile-handle"></div>
      
      <div class="modal-img-container">
        <img src="${item.image}" alt="${item.title}">
      </div>

      <div class="modal-product-info">
        <div style="display:flex; justify-content:space-between; align-items:flex-start;">
          <span class="product-category-meta">${item.categoryName}</span>
          <button class="close-btn" onclick="closeProductModal()" aria-label="Close dialog">&times;</button>
        </div>

        <h2 style="font-size:1.4rem; margin:6px 0 10px; line-height:1.3;">${item.title}</h2>

        <div class="rating-row" style="margin-bottom:10px;">
          <span class="stars" style="color:var(--accent);">★★★★★</span>
          <span class="reviews-count">${item.rating} out of 5 stars (${item.reviews.toLocaleString()} Amazon reviews)</span>
        </div>

        <div class="price-row" style="margin: 10px 0 14px;">
          <span class="current-price" style="font-size: 1.6rem;">${formatPrice(item.price)}</span>
          <span class="original-price" style="font-size: 1rem;">${formatPrice(item.originalPrice)}</span>
          <span class="discount-tag">${discount}% OFF · Prime Verified</span>
        </div>

        <p style="font-size:0.88rem; color:var(--text-muted); margin-bottom:14px; line-height:1.55;">
          ${item.description}
        </p>

        <div class="size-selector">
          <span>Available Sizes:</span>
          <div class="sizes-list">
            ${item.sizes.map((s, idx) => `
              <button class="size-btn ${idx === 0 ? 'active' : ''}" onclick="selectSize(this)">${s}</button>
            `).join('')}
          </div>
        </div>

        <div style="background:#fdf6ed; border:1px solid #fde68a; border-radius:var(--radius-sm); padding:10px 12px; margin-bottom:18px; font-size:0.8rem; color:#92400e;">
          🛡️ <strong>Official Amazon India Listing:</strong> Fulfilled by Amazon. Enjoy Prime 1-day/2-day delivery, secure checkout with UPI, Cards or Netbanking, and hassle-free returns.
        </div>

        <a href="${affUrl}" target="_blank" rel="sponsored noopener noreferrer" class="btn-amazon-buy" style="padding:13px; font-size:0.95rem;">
          <svg viewBox="0 0 24 24" fill="currentColor" style="width:20px; height:20px;">
            <path d="M15.42 13.56c-.32-.23-.74-.23-1.06 0l-3.36 2.45-1.57-1.15a.89.89 0 0 0-1.06 0l-2.09 1.53c-.32.23-.42.66-.23 1 .19.34.62.48.97.28l1.59-1.16 1.57 1.15c.32.23.74.23 1.06 0l3.88-2.83c.32-.23.42-.66.23-1a.78.78 0 0 0-.93-.27zM21.71 16.29c-1.35 1.54-3.4 2.68-5.69 2.68-3.07 0-5.83-2.05-6.72-4.99-.09-.3-.41-.47-.72-.38-.3.09-.47.41-.38.72 1.05 3.47 4.3 5.88 7.92 5.88 2.7 0 5.12-1.34 6.7-3.15.22-.25.19-.63-.06-.85a.61.61 0 0 0-.85.09z"/>
            <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.41 0-8-3.59-8-8s3.59-8 8-8 8 3.59 8 8-3.59 8-8 8z"/>
          </svg>
          Buy on Amazon with Prime →
        </a>
      </div>
    </div>
  `;

  modal.classList.add('active');
  document.body.style.overflow = 'hidden';
}

function closeProductModal() {
  const modal = document.getElementById('productDetailModal');
  if (modal) modal.classList.remove('active');
  document.body.style.overflow = '';
}

function selectSize(btn) {
  document.querySelectorAll('.size-btn').forEach(b => b.classList.remove('active'));
  btn.classList.add('active');
}


function toggleWishlist(id) {
  const index = wishlist.indexOf(id);
  const item = products.find(p => p.id === id);

  if (index > -1) {
    wishlist.splice(index, 1);
    showToast(`Removed from saved favorites`);
  } else {
    wishlist.push(id);
    showToast(`Saved "${item ? item.title.slice(0, 20) + '...' : ''}" to Wishlist!`);
  }

  localStorage.setItem('curate_wishlist', JSON.stringify(wishlist));
  updateWishlistUI();
  renderProducts();
}

function updateWishlistUI() {
  const badge = document.getElementById('wishlistCount');
  if (badge) {
    badge.textContent = wishlist.length;
  }
  const bottomBadge = document.getElementById('bottomWishlistCount');
  if (bottomBadge) {
    bottomBadge.textContent = wishlist.length;
  }
}

function openWishlistDrawer() {
  const overlay = document.getElementById('wishlistOverlay');
  const drawer = document.getElementById('wishlistDrawer');
  const container = document.getElementById('wishlistItemsList');

  const savedItems = products.filter(p => wishlist.includes(p.id));

  if (savedItems.length === 0) {
    container.innerHTML = `
      <div style="text-align: center; padding: 40px 10px;">
        <p style="color: var(--text-muted); font-size:0.95rem;">Your wishlist is currently empty.</p>
        <p style="font-size:0.8rem; color:var(--text-light); margin-top:6px;">Heart any outfit card to save it for later!</p>
      </div>
    `;
  } else {
    container.innerHTML = savedItems.map(item => `
      <div class="wishlist-item">
        <img src="${item.image}" alt="${item.title}">
        <div class="wishlist-item-info">
          <div class="wishlist-item-title">${item.title}</div>
          <div class="wishlist-item-price">${formatPrice(item.price)}</div>
          <a href="${buildAmazonUrl(item.asin, item.title, item.shortUrl)}" target="_blank" rel="sponsored noopener noreferrer" style="font-size:0.75rem; color:var(--accent); font-weight:700; text-decoration:underline;">Buy on Amazon</a>
        </div>
        <button onclick="toggleWishlist('${item.id}'); openWishlistDrawer();" style="background:none; color:var(--text-light); font-size:1.2rem; cursor:pointer;" title="Remove">&times;</button>
      </div>
    `).join('');
  }

  overlay.classList.add('active');
  drawer.classList.add('active');
  document.body.style.overflow = 'hidden';
}

function closeWishlistDrawer() {
  const overlay = document.getElementById('wishlistOverlay');
  const drawer = document.getElementById('wishlistDrawer');
  if (overlay) overlay.classList.remove('active');
  if (drawer) drawer.classList.remove('active');
  document.body.style.overflow = '';
}

/**
 * Mobile Navigation Drawer Toggle
 */
function toggleMobileNav() {
  const overlay = document.getElementById('mobileNavOverlay');
  const drawer = document.getElementById('mobileNavDrawer');
  if (!drawer) return;

  const isOpen = drawer.classList.contains('active');
  if (isOpen) {
    drawer.classList.remove('active');
    if (overlay) overlay.classList.remove('active');
    document.body.style.overflow = '';
  } else {
    drawer.classList.add('active');
    if (overlay) overlay.classList.add('active');
    document.body.style.overflow = 'hidden';
  }
}

/**
 * Focus and scroll to Search Bar
 */
function focusSearch() {
  const searchInput = document.getElementById('searchInput');
  if (searchInput) {
    searchInput.focus();
    searchInput.scrollIntoView({ behavior: 'smooth', block: 'center' });
  }
}

/**
 * Set Active State on Bottom Bar
 */
function setActiveBottomTab(element) {
  document.querySelectorAll('.bottom-bar-item').forEach(b => b.classList.remove('active'));
  if (element) element.classList.add('active');
}

/**
 * Toast Notifications
 */
function showToast(msg) {
  const toast = document.getElementById('toastNotification');
  if (!toast) return;
  toast.textContent = msg;
  toast.classList.add('show');
  setTimeout(() => {
    toast.classList.remove('show');
  }, 3000);
}

/**
 * Initialization & Event Listeners
 */
document.addEventListener('DOMContentLoaded', () => {
  updateWishlistUI();
  renderProducts();

  // Search Input Handler
  const searchInput = document.getElementById('searchInput');
  if (searchInput) {
    searchInput.addEventListener('input', (e) => {
      searchQuery = e.target.value;
      renderProducts();
    });
  }

  // Sort Dropdown Handler
  const sortSelect = document.getElementById('sortSelect');
  if (sortSelect) {
    sortSelect.addEventListener('change', (e) => {
      currentSort = e.target.value;
      renderProducts();
    });
  }

  // Close modals on Escape key
  document.addEventListener('keydown', (e) => {
    if (e.key === 'Escape') {
      closeProductModal();
      closeWishlistDrawer();
      const mobileDrawer = document.getElementById('mobileNavDrawer');
      if (mobileDrawer && mobileDrawer.classList.contains('active')) {
        toggleMobileNav();
      }
    }
  });
});
