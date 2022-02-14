# Change Log

<!-- markdownlint-disable MD024 no-duplicate-heading -->
<!-- ## [Unreleased 0.0.1] -->

## [Unreleased 0.0.1]

### Fixed

- `kati_dark.css` for Markdown plugin,
  - to render a nested ordered list in an unordered to an ordered list, not as an unordered list.
  - commented out `div.section p` to avoid unnecessary indents right before and after
   blank lines in an item list in markdown block.

### Added

- `Help_Markdown_for_FreeStyleWiki.htm`
- Common settings among themes in the head of `kati_dark.css`, such as,
  - `textarea.edit {; width: 100%;}` to fit the width of textarea in edit with browser.
  - Settings for Content Security Policy (CSP) and plugin/markdown/Markdown.pm.

### Changed

- Made the text area dark.
- `EUC-JP (LF)` to `UTF-8 (LF)` in `kati_dark.css`.

<!--
## Template
### Added
### Changed
### Deprecated
### Removed
### Fixed
### Security
-->
