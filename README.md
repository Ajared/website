# Ajared Research Inc — Website

Static website for [ajared.ca](https://ajared.ca). Built with HTML, CSS, and vanilla JS. No build step required.

---

## Pages

| File | Route |
|---|---|
| `index.html` | Homepage |
| `case-studies.html` | Case Studies |
| `capabilities.html` | Capabilities |
| `contact.html` | Contact / Inquiry |

---

## Deploying to GitHub Pages

### 1. Create a repository

Go to [github.com/organizations/Ajared/repositories/new](https://github.com/organizations/Ajared/repositories/new) and create a new repository under the **Ajared** org, e.g. `website`. Set it to **Public** (required for free GitHub Pages).

### 2. Push the files

From inside this folder, run:

```bash
git init
git add .
git commit -m "Initial site deploy"
git branch -M main
git remote add origin https://github.com/Ajared/website.git
git push -u origin main
```

### 3. Enable GitHub Pages

1. Go to [github.com/Ajared/website](https://github.com/Ajared/website)
2. Click **Settings → Pages**
3. Under **Source**, select `Deploy from a branch`
4. Set branch to `main`, folder to `/ (root)`
5. Click **Save**

Your site will be live at:
```
https://ajared.github.io/website/
```

> If you have a custom domain (e.g. `ajared.ca`), add a `CNAME` file to this folder containing just your domain name, then point your DNS to GitHub's servers per their [custom domain docs](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site).

---

## Setting up the Contact Form (Formspree)

The contact form uses [Formspree](https://formspree.io) to deliver submissions to `innovation@ajared.ca`. You need to complete a one-time setup:

### 1. Create a free Formspree account

Go to [formspree.io](https://formspree.io) and sign up with `innovation@ajared.ca`.

### 2. Create a new form

In the Formspree dashboard, click **+ New Form**. Name it `Ajared Website Inquiry`. Formspree will give you a form ID that looks like: `xyzabcde`.

### 3. Update contact.html

Open `contact.html` and find this line near the top of the form:

```html
<form id="commission-form" action="https://formspree.io/f/YOUR_FORM_ID" method="POST">
```

Replace `YOUR_FORM_ID` with the ID from your Formspree dashboard, e.g.:

```html
<form id="commission-form" action="https://formspree.io/f/xyzabcde" method="POST">
```

### 4. Verify your email

Formspree will send a confirmation email to `innovation@ajared.ca` the first time the form is submitted. Click the link to activate delivery.

That's it — submissions will arrive in your inbox with the sender's name, email (as reply-to), and project brief.

---

## Notes

- Google Fonts (`Inter`) loads from `fonts.googleapis.com` — requires an internet connection to render correctly.
- The coordinate selector on the contact page is decorative / interactive only; coordinates are not submitted with the form.
- No frameworks, no build tools, no dependencies beyond Google Fonts.
