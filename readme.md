# DOCX to PDF Converter with Placeholder Replacement

This Ruby utility replaces placeholders in a `.docx` file with provided values and converts the result to a PDF using LibreOffice.

## Features

- Replace placeholders like `{{name}}`, `{{date}}`, etc. in a Word document.
- Generate a filled PDF version of the document.
- Temporary files are managed in the system temp directory.
- Safe file generation using `SecureRandom`.

## Requirements

- Ruby (>= 2.5)
- [LibreOffice](https://www.libreoffice.org/) installed and available as `soffice` in the system path
- Gems:
  - `docx`
  - `securerandom`

Install required gems:

```bash
gem install docx
