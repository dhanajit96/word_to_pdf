require 'docx'
require 'securerandom'
require_relative 'word_to_pdf/install_check'

module WordToPdf
  def self.convert(_input_docx_file_path, _output_pdf_file_path, values_hash = {})
    InstallCheck.ensure_office_installed!

    temp_dir = "/tmp/#{SecureRandom.hex(8)}"
    Dir.mkdir(temp_dir) unless File.exist?(temp_dir)

    doc = Docx::Document.open(input_docx)

    doc.paragraphs.each do |p|
      values_hash.each do |key, value|
        p.text = p.text.gsub("{{#{key}}}", value.to_s)
      end
    end

    filled_docx = "#{temp_dir}/filled_template.docx"
    doc.save(filled_docx)

    system("soffice --headless --convert-to pdf #{filled_docx} --outdir #{temp_dir}")

    generated_pdf = filled_docx.gsub('.docx', '.pdf')
    File.rename(generated_pdf, output_pdf)

    puts "PDF generated: #{output_pdf}"
  end
end
