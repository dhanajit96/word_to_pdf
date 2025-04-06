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

### Install:

Add the following line to your application's Gemfile:
```
gem 'docx'
gem 'word_to_pdf'
```
And then execute:

```
bundle install
```
Or install it yourself as:

```
gem install docx
```

### Convert

first create a template sample word file(.docx)

```word
This is test file
Name: {{name}}
date of birth: {{date}}
```

or \

You can download a sample `.docx` template to test this gem:

👉 [Click here to get the sample file](https://github.com/dhanajit96/word_to_pdf/raw/refs/heads/main/spec/fixtures/template.docx)



```ruby
require 'word_to_pdf'

WordToPdf.convert(
  '/path/to/template.docx',
  '/path/to/output.pdf',
  {
    first_name: 'Test',
    last_name: 'Example'
  }
)
```

You will have the downloaded file on the `/path/to/output.pdf` location


