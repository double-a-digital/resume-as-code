const { chromium } = require("playwright")
const path = require("path")

async function generatePdfFromFile() {
  const browser = await chromium.launch()
  const page = await browser.newPage()

  const htmlFilePath = path.join(__dirname, "index.html")
  const fileUrl = `file://${htmlFilePath}`

  console.log(`Loading HTML from: ${fileUrl}`)
  await page.goto(fileUrl)

  await page.pdf({
    path: "resume.pdf",
    preferCSSPageSize: true,
  })

  console.log(
    "PDF generated successfully from local file: resume.pdf"
  )

  await browser.close()
}

generatePdfFromFile()
