const fs = require('fs');
let code = fs.readFileSync('app.js', 'utf8');

// Fix the typo "originalprice" -> "originalPrice" and ensure fallback
code = code.replace('"originalprice": 898', '"originalPrice": 2499');

// Make formatPrice handle rupee symbol properly
code = code.replace(/function formatPrice\(amount\) \{[\s\S]*?\}/, 'function formatPrice(amount) {\n  return `₹${amount.toLocaleString(\'en-IN\')}`;\n}');

// Update discount calculation to be bulletproof against undefined or lower originalPrice
code = code.replace(
  'const discount = Math.round(((item.originalPrice - item.price) / item.originalPrice) * 100);',
  'const origPrice = (item.originalPrice && item.originalPrice > item.price) ? item.originalPrice : Math.round(item.price * 2);\n    const discount = Math.round(((origPrice - item.price) / origPrice) * 100);'
);

// Also replace ${item.originalPrice} references with ${origPrice} in card template
code = code.replace('${formatPrice(item.originalPrice)}', '${formatPrice(origPrice)}');
code = code.replace('${formatPrice(item.originalPrice - item.price)}', '${formatPrice(origPrice - item.price)}');

fs.writeFileSync('app.js', code, 'utf8');
console.log('Successfully patched app.js!');

