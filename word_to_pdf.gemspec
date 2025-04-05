Gem::Specification.new do |s|
  s.authors = ['Ajit Dhanje']
  s.files = Dir['lib/**/*.rb']
  s.name = 'word_to_pdf'
  s.summary = 'A gem to convert word file formated to pdf can be used for invoicing and other template'
  s.version = '0.0.1'
  s.add_dependency 'docx', '~> 0.8.0'
end
