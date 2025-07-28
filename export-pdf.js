const { chromium } = require("playwright")
const path = require("path")
const FILE_PATH = process.env.FILE_PATH || "."

async function generatePdfFromFile(FILE_PATH) {
  const browser = await chromium.launch()
  const page = await browser.newPage()

  const htmlFilePath = path.join(__dirname, `${FILE_PATH}/index.html`)
  const fileUrl = `file://${htmlFilePath}`

  console.log(`Loading HTML from: ${fileUrl}`)
  await page.goto(fileUrl)

  await page.pdf({
    path: `${FILE_PATH}/resume.pdf`,
    preferCSSPageSize: true,
  })

  console.log(
    `PDF generated successfully from ${FILE_PATH}/index.html as ${FILE_PATH}/resume.pdf 🚀`
  )

  await browser.close()
}

generatePdfFromFile(FILE_PATH)
