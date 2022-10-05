# Change Log

<!-- markdownlint-disable MD024 no-duplicate-heading -->
<!-- ## [Unreleased 0.0.2] -->

## [0.0.1]

### Fixed

- `kati_dark.css` for Markdown plugin,
  - to render a nested ordered list in an unordered to an ordered list, not as an unordered list.
  - commented out `div.section p` to avoid unnecessary indents right before and after
   blank lines in an item list in markdown block.

### Added

- `Help_Markdown_for_FreeStyleWiki.htm`
- common settings among themes in the head of `kati_dark.css`, such as,
  - `textarea.edit {; width: 100%;}` to fit the width of textarea in edit with browser.
  - settings for Content Security Policy (CSP) and plugin/markdown/Markdown.pm.
  - auto line-feed in code blocks.
- info of Discount markdown 2.2.7\* in Help/Markdown.

### Changed

- discount markdown 2.2.7b (v2maint 68db3cd), which is newer than 2.2.7 (v2maint 34a8ebb).
- text-edit-area dark.
- style components himg2.jpg and list_a.gif more dark friendly.
- `EUC-JP (LF)` to `UTF-8 (LF)` in `kati_dark.css`.
- links to Help/Markdown (HTML).

<!--
## Template
### Added
### Changed
### Deprecated
### Removed
### Fixed
### Security
-->
