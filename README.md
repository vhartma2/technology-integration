# Working on the web book

This folder is the Quarto edition of *What Does the Tool Make Possible?*. Make web-edition updates here so there is one working copy to maintain for publication.

- `_quarto.yml` sets the title, cover, and reading order.
- `index.qmd` is the home page. The chapter files are in `chapters/`. A `.qmd` file is a text file you can edit like Markdown.
- `figures/` holds the artwork. `resources/` holds the sample data and its facilitation guide.

## Preview a change

1. Install [Quarto](https://quarto.org/docs/download/).
2. Open Terminal in this folder and run `quarto preview`. Quarto builds the site and opens a browser on your computer. Press Control+C in Terminal to stop the preview.
3. Open Chapter 3 and check its navigation, figure, rubric, and CAST links. Try a narrow window and use the Tab key to move through the page. Open the sample CSV and workbook from the facilitation guide.
4. To practice, edit the welcome paragraph in `index.qmd`, save it, and check the browser. Restore the original wording if it was a practice edit.

## How GitHub fits

Once the preview is ready to share, this folder can become its own GitHub repository. A commit is a saved version with a short note about what changed. GitHub stores those versions, and GitHub Pages serves the web book Quarto builds. The generated `_book/` folder is an output of Quarto. Make revisions in the source files.

## Publish for the first time

1. Sign in to [GitHub Desktop](https://desktop.github.com/download/). Choose **File → Add Local Repository** and select this `quarto-book` folder. If Desktop offers to create a repository here, follow its **create a repository** link. Check that the final folder ends in `quarto-book` and that there is no extra nested folder. Keep the existing README and ignore file.
2. In GitHub Desktop, check that the repository contains the book source, images, and downloads. In the Changes tab, commit anything that Desktop has left uncommitted. Choose **Publish repository**, enter a public-facing repository name if desired, and clear **Keep this code private** to use GitHub Pages on GitHub Free.
3. On GitHub, open the repository and choose **Settings → Pages**. Under **Build and deployment**, choose **GitHub Actions** as the source.
4. Open **Actions → Publish textbook → Run workflow**, choose `main`, and run it. If the first run started before Pages was configured, use this step to run it again. When the workflow succeeds, **Settings → Pages** shows the reader URL.
5. For later updates, preview, commit, and choose **Push origin** in Desktop. A push to `main` triggers the workflow, which renders the book and updates the public site.
