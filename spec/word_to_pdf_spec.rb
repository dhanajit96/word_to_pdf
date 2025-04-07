require 'spec_helper'
require 'word_to_pdf'
require 'fileutils'

RSpec.describe WordToPdf do
  let(:template_path) { 'spec/fixtures/template.docx' }
  let(:values)        { { first_name: 'उत्कर्ष', last_name: 'प्रतिक्षा' } }
  let(:output_pdf)    { 'spec/output/test_output.pdf' }

  before(:all) do
    FileUtils.mkdir_p('spec/output')
  end

  describe '.convert' do
    it 'generates a PDF from DOCX with replaced placeholders' do
      expect do
        described_class.convert(template_path, output_pdf, values)
      end.not_to raise_error

      expect(File).to exist(output_pdf)
    end
  end

  describe '.create_temp_dir' do
    it 'creates a unique temporary directory' do
      temp_dir = described_class.create_temp_dir
      expect(File).to exist(temp_dir)
      expect(temp_dir).to match(%r{/tmp/[a-f0-9]{16}})
    end
  end

  describe '.fill_template' do
    it 'replaces placeholders and returns path to filled DOCX file' do
      temp_dir = described_class.create_temp_dir
      filled_docx = described_class.fill_template(template_path, values, temp_dir)

      expect(File).to exist(filled_docx)

      doc = Docx::Document.open(filled_docx)
      text = doc.paragraphs.map(&:text).join(" ")

      values.each_value do |val|
        expect(text).to include(val)
      end
    end
  end

  describe '.convert_to_pdf' do
    it 'converts a DOCX to a PDF in the specified directory' do
      temp_dir = described_class.create_temp_dir
      filled_docx = described_class.fill_template(template_path, values, temp_dir)

      pdf_path = described_class.convert_to_pdf(filled_docx, temp_dir)
      sleep 1 # Give it a moment for file system to catch up

      expect(File).to exist(pdf_path)
    end
  end

  describe '.move_pdf_to_destination' do
    it 'moves the PDF file to the final output path' do
      temp_dir = described_class.create_temp_dir
      filled_docx = described_class.fill_template(template_path, values, temp_dir)
      temp_pdf = described_class.convert_to_pdf(filled_docx, temp_dir)

      final_path = 'spec/output/final_moved_output.pdf'
      File.delete(final_path) if File.exist?(final_path)

      described_class.move_pdf_to_destination(temp_pdf, final_path)

      expect(File).to exist(final_path)
    end
  end
end
