#!/bin/bash
set -e

echo "Building resume..."

echo "Install dependencies"
npm ci
npx playwright install chromium

echo "Generate HTML"
npm run export-html

echo "Prepare HTML for PDF export"
sed -i 's/margin: 10mm 25mm;/margin: 5mm 5mm;/g' index.html

echo "Generate PDF"
npm run export-pdf

echo "Add links and embed PDF"
echo '<a href="./resume.pdf" target="_blank"><p>Download PDF</p></a>' >> index.html
echo '<embed src="./resume.pdf" type="application/pdf" width="100%" height="100%" />' >> resume.html

echo "Resume build completed successfully!"