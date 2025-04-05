# lib/docx_to_pdf/install_check.rb
module WordToPdf
  class InstallCheck
    def self.ensure_office_installed!
      return if system('which soffice > /dev/null')

      abort <<~MSG
        ❌ LibreOffice is not installed or 'soffice' is not in PATH.
        ➤ Please install it manually:
          • On Ubuntu/Debian: sudo apt install libreoffice
          • On macOS (with Homebrew): brew install --cask libreoffice
          • On Windows: Download from https://www.libreoffice.org/download/

        Then run this gem again.
      MSG
    end
  end
end
