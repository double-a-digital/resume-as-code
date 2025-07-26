# 📄 Resume as Code </>

Manage your resume in a single resume.json file. Automatically generate a personal resume website and downloadable PDF hosted for free via GitHub Pages.

Powered by: [JSONResume](https://jsonresume.org/) + Engineering [Theme](https://github.com/skoenig/jsonresume-theme-engineering)

Guided by: [ r/EngineeringResumes](https://www.reddit.com/r/EngineeringResumes/wiki/index/)

---

## 🚀 Features

- One Source of Truth - Just edit resume.json

- Automatic Builds - HTML & PDF generated on every push

- Live Preview - Hosted with GitHub Pages

- Ready-to-Download PDF - Built using Playwright for print-optimized formatting

- Clean Theme - Minimal, readable, and ATS-friendly

---

## 🔧 How It Works

1. You update resume.json

2. GitHub Actions builds the site and PDF automatically

3. Output is deployed to a separate repository for hosting via GitHub Pages

    💡 This lets you keep the build process private, and make your resume public only when you need to.

---

## 🔑 Pre-requisites

1. Go to: **Settings** → **Developer Settings** → **Personal Access Tokens** → Generate **new token (classic)**

   - Name it something like Resume Automation

   - Scope: repo

   - Copy and save the token

# 🛠️ Set It Up

1. Click `Use this template` (top of this repo) → Choose **Private**

2. Go to: **Settings** → **Secrets and variables** → **Actions**
   - Secrets
      - ACTIONS_PAT → your GitHub token from earlier
   - Variables
      - DEST_USERNAME → your GitHub username
      - DEST_REPO_NAME → name of the destination repo (e.g. my-resume)

3. Create your destination repo
   -  Name it something like my-resume
   -  Initialize with a README

4. Go to destination repo **Settings** → **Pages** → Choose branch: **main** → **Save**

5. Clone your template repo & set up

```bash
git clone <your-template-repo-url>
cd <your-repo-name>
cp sample-resume.json resume.json
git add resume.json
git commit -m "feat: initial commit"
git push origin main
```

---

## 💻 Run Locally (Optional)

Want to preview your resume before pushing?

Powered by: [resumed](https://github.com/rbardini/resumed)

1. Install Node.js & Playwright

```bash
npm install
npx playwright install chromium
```

1. Create Your Resume

```bash
cp sample-resume.json resume.json
```

1. Generate HTML & PDF

```bash
npm run export-html
npm run export-pdf
```

You’ll find `index.html` and `resume.pdf` in the project folder.

## Why This?

Most resume builders hide the details. This template gives you full control. Version it with Git, write in JSON, and generate polished outputs with developer tools.

✅ No WYSIWYG
✅ No fees
✅ Just code and GitHub Actions magic
