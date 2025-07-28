const { chromium } = require("playwright")
const path = require("path")
const filePath = process.env.filePath || "."

async function generatePdfFromFile(filePath) {
  const browser = await chromium.launch()
  const page = await browser.newPage()

  const htmlFilePath = path.join(__dirname, `${filePath}/index.html`)
  const fileUrl = `file://${htmlFilePath}`

  console.log(`Loading HTML from: ${fileUrl}`)
  await page.goto(fileUrl)

  await page.pdf({
    path: `${filePath}/resume.pdf`,
    preferCSSPageSize: true,
  })

  console.log(
    `PDF generated successfully from ${filePath}/index.html as ${filePath}/resume.pdf 🚀`
  )

  await browser.close()
}

generatePdfFromFile(filePath)
