# AI-103 Course Orientation

A single-page, community study aid for **Exam AI-103: Develop AI apps and agents on Azure** —
the exam, its five skill domains, the five hands-on lab repos, and the vocabulary the current
exam grades on. Every Azure fact links to its Microsoft Learn source.

**Live site:** https://jmrydman.github.io/ai-103-orientation

> Independent and unofficial. Not affiliated with or endorsed by Microsoft. All product names and
> course codes belong to Microsoft; the authoritative source is always the linked Learn page.

## How it's built

The site is a single [Quartz 4](https://quartz.jzhao.xyz) page. Its **source of truth** is one
note in a private Obsidian study vault; `sync.sh` copies that single, explicitly-public note into
`content/index.md`. Nothing else in the vault can reach the site — see the guardrail below.

```
Obsidian vault (private study notes)
  └─ 07 Resources/AI-103 Course Orientation.md   ← source of truth (visibility: public)
        │  ./sync.sh  (copies EXACTLY this one file)
        ▼
      content/index.md
        │  npx quartz build   (or: GitHub Actions on push)
        ▼
      public/  →  GitHub Pages
```

### Publishing

```bash
./publish.sh "your commit message"
```

That syncs the vault note → `content/index.md`, commits, and pushes. The GitHub Actions workflow
in `.github/workflows/deploy.yml` builds Quartz and deploys to Pages (live in ~1–2 minutes). You
don't need Node locally to publish — the build runs on GitHub.

### The guardrail

Because the source vault is a **private** study vault, `sync.sh` never globs folders. It copies
exactly one named file and **refuses to run** unless that file's frontmatter says
`visibility: public`. No other note can ever be published by accident.

## Local preview

```bash
npm ci
./sync.sh
npx quartz build --serve   # http://localhost:8080
```

## License

- **Site content** (`content/`): [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/) — reuse with attribution.
- **Code / Quartz configuration**: MIT (see `LICENSE`). Quartz itself is MIT (see `LICENSE.txt`, © jackyzha0).
