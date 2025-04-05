require 'spec_helper'
require 'word_to_pdf'
require 'fileutils'

RSpec.describe WordToPdf do
  let(:template_path) { 'spec/fixtures/template.docx' }
  let(:output_pdf)    { 'spec/output/test_output.pdf' }
  let(:values)        { { first_name: 'उत्कर्ष', last_name: 'प्रतिक्षा' } }

  before(:all) do
    FileUtils.mkdir_p('spec/output')
  end

  it 'generates a PDF from DOCX with replaced placeholders' do
    expect do
      described_class.convert(template_path, output_pdf, values)
    end.not_to raise_error

    expect(File).to exist(output_pdf)
  end
end
