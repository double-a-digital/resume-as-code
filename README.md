# 📄 Resume as Code </>

Manage your resume in a single JSON file `resume.json` and auto-generate a free site hosted by GitHub with downloadable PDF.

Powered by: [JSONResume](https://jsonresume.org/) + Engineering [Theme](https://github.com/skoenig/jsonresume-theme-engineering)

No fancy stuffs, just KISS resume for ATS following these [principles](https://www.reddit.com/r/EngineeringResumes/wiki/index/)

---

## 🚀 Features

- Edit One File - Your resume lives in resume.json

- Auto Builds - HTML and PDF generated on every push

- Live Preview - Always up to date via GitHub Pages

- Download in PDF - Uses Playwright for better printed version

- Minimal theme - ATS-friendly for developers by developers

---

## 🔧 How It Works

1. Update resume.json

2. Push to main branch

3. GitHub Actions:
   - Build artifacts needed for the resume contents
   - Deploy them to a separate GitHub repository
   - GitHub Pages automatically host the webpage on that repository

4. Reason the GitHub Pages for the resume contents is on a separate repository is so we can control its visibility (eg: toggle it to public only for when a recruiter requests for it)

---

## ⚙️ Pre-requisites

1. Go to your GitHub **Settings** > **Developer settings** > **Personal access tokens** > **Tokens (classic)** and click Generate new token.

2. Give the token a name and check the repo scope. This will grant it permission to access and write to repositories.

3. Copy the generated token immediately. You won't be able to see it again.

# 🛠️ Get Started For Your Own

1. Click "Use this template" to copy the repo. Make it Private.

2. In the left sidebar, navigate to **Secrets and variables** > **Actions**.

3. Create New repo secret with token generated previously
   -  Name: ACTIONS_PAT
      -  Value: Your GitHub PAT.

4. Create New repo variables:
   - Name: DEST_USERNAME
        - Value: Your GitHub username.
   - Name: DEST_REPO_NAME
        - Value: The name of the destination repository (eg: my-resume).

5. Create a new GitHub repository (eg: my-resume) and initialize with README file.

6. Go to the new repository **Settings** > **Pages** > **Branch** (select **main**) > **Save**

7. Clone the repository made from the template previously
```
git clone <your-repo-url>
cd <your-repo-name>
```

8. Copy the sample resume and start editing.
```
cp sample-resume.json resume.json
git add resume.json
git commit -m "feat: initial commit"
git push origin main
```

---

## 💻 Run Locally (Optional)

If you want to see how it look like before publishing, here's how.

Powered by: [resumed](https://github.com/rbardini/resumed)

1. Install Node.js & Playwright
```
npm install
npx playwright install chromium
```

2. Create Your Resume
```
cp sample-resume.json resume.json
```

3. Generate HTML & PDF
```
npm run export-html
npm run export-pdf
```

You’ll find index.html and resume.pdf in the project folder.
