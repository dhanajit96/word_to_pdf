require 'docx'
require 'securerandom'
require_relative 'word_to_pdf/install_check'

module WordToPdf
  
  def self.convert(input_docx_file_path, output_pdf_file_path, values_hash = {})
    # Checking if the soffice is avaliable or not
    InstallCheck.ensure_office_installed!

    temp_dir = create_temp_dir
    filled_docx = fill_template(input_docx_file_path, values_hash, temp_dir)
    pdf_path = convert_to_pdf(filled_docx, temp_dir)

    move_pdf_to_destination(pdf_path, output_pdf_file_path)

    puts "PDF generated: #{output_pdf_file_path}"
  end

  # creating empty tmp directory
  def self.create_temp_dir
    temp_dir = "/tmp/#{SecureRandom.hex(8)}"
    Dir.mkdir(temp_dir) unless File.exist?(temp_dir)
    temp_dir
  end

  def self.fill_template(input_docx_file_path, values_hash, temp_dir)
    doc = Docx::Document.open(input_docx_file_path)

    doc.paragraphs.each do |p|
      values_hash.each do |key, value|
        p.text = p.text.gsub("{{#{key}}}", value.to_s)
      end
    end

    filled_docx = "#{temp_dir}/filled_template.docx"
    doc.save(filled_docx)
    filled_docx
  end

  def self.convert_to_pdf(filled_docx_path, output_dir)
    system("soffice --headless --convert-to pdf #{filled_docx_path} --outdir #{output_dir}")
    filled_docx_path.gsub('.docx', '.pdf')
  end

  def self.move_pdf_to_destination(temp_pdf_path, final_output_path)
    File.rename(temp_pdf_path, final_output_path)
  end
end
