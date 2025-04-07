require_relative 'lib/word_to_pdf/version'

Gem::Specification.new do |s|
  s.authors = ['Ajit Dhanje']
  s.files = Dir['lib/**/*.rb']
  s.email = ['ajitdhanje@gmail.com']
  s.license = "MIT"
  s.name = 'word_to_pdf'
  s.summary = 'A gem to convert word file(.docx) to pdf can be used for invoicing and other template'
  s.version = WordToPdf::VERSION
  s.add_dependency 'docx', '~> 0.8.0'
  s.require_paths = ['lib']
  s.metadata['source_code_uri'] = 'https://github.com/dhanajit96/word_to_pdf.git'
  s.required_ruby_version = '>= 3.1.0'
end
