<img width="867" height="265" alt="resume-as-code" src="https://github.com/user-attachments/assets/ab42ab59-e8f3-49d9-a193-40007a9a99e0" />

---

# 📄 Introduction </>

Manage multiple resumes, with each getting its own `resume.json` file.

Automatically generate a professional resume website with a downloadable PDF for each version, hosted for free via GitHub Pages.

Powered by: [JSONResume](https://jsonresume.org/) + Engineering [Theme](https://github.com/skoenig/jsonresume-theme-engineering) + [GH Pages](https://pages.github.com/)

Guided by: [r/EngineeringResumes](https://www.reddit.com/r/EngineeringResumes/wiki/index/)

## 🚀 Features

- **Multi-Resume Support** - Manage different resumes for different roles in one place.
- **One Source of Truth** - Just edit the `resume.json` for the resume you want to change.
- **Automatic Builds & Deploys** - Websites are generated and deployed on every push.
- **Live Websites** - Each resume is hosted with GitHub Pages for free in its own repository.
- **Download PDF** - A print-optimized PDF version is included for each resume.
- **Clean Theme** - Minimal, readable and ATS-friendly.

## 🔧 How It Works

1.  You create a new folder inside the `resumes/` directory (e.g., `resumes/data-scientist/`).
2.  You add a `resume.json` file to this new folder.
3.  GitHub Actions automatically builds the site and PDF.
4.  The output is deployed to a separate resume repository (e.g., `data-scientist-resume`) for hosting via GitHub Pages.
5.  If you delete a resume folder, the corresponding repository is also deleted.

💡 This lets you keep your resume source and its commit history private, while only making the live resume websites public.

## 🔑 Pre-requisites

1.  Go to: **Settings** → **Developer Settings** → **Personal Access Tokens** → Generate **new token (classic)**
    -   Name it: `resume_token`
    -   Scope: `repo` & `delete_repo`
    -   Copy and save the token.

# 🛠️ Set It Up

1.  Click `Use this template` (top of this repo) → Choose **Private**.

2.  Go to: **Settings** → **Secrets and variables** → **Actions**
    -   **Secrets**
        -   `ACTIONS_PAT` → your GitHub token from earlier.

3.  Create your first resume:
    ```bash
    git clone <your-repo-url>
    cd <your-repo-name>

    # Create a directory for your new resume
    mkdir -p resumes/data-scientist

    # Copy the sample and start editing
    cp sample-resume.json resumes/data-scientist/resume.json
    ```

4.  After editing `resumes/data-scientist/resume.json`, commit and push the changes:
    ```bash
    git add resumes/data-scientist/resume.json
    git commit -m "feat: intial commit"
    git push origin main
    ```

All done! You'll be able to access your live site at `https://<github_username>.github.io/data-scientist-resume`.

_It's highly recommended to keep the generated resume repository (e.g., `data-scientist-resume`) private and only make it public when needed._

## 💻 Run Locally (Optional)

Want to preview your resume before pushing?

1.  Install dependencies:
    ```bash
    npm install
    npx playwright install chromium
    ```

2.  To build a specific resume, run the `build-resume.sh` script with the `FILE_PATH` environment variable pointing to your resume's directory:
    ```bash
    FILE_PATH=resumes/data-scientist ./scripts/build-resume.sh
    ```

You’ll find the generated `index.html`, `resume.html`, and `resume.pdf` inside the `resumes/data-scientist/` folder.

## 🤖 Why This?

This template gives you full control.

Version your resumes with Git, write them in JSON, and generate polished outputs with developer tools.

✅ No un-versioned resume edits

✅ No monthly subscription fees

✅ Just code and GitHub Actions magic