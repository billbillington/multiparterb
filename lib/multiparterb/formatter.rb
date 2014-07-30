module MultipartErb
  mattr_accessor :processing_options, :renderer

  class Formatter
    def self.to_html(compiled_source)
      compiled_source
    end

    def self.to_text(compiled_source)
      compiled_source
    end
  end
end
