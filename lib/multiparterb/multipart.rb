module MultipartErb
  mattr_accessor :processing_options, :renderer

  class Multipart
    def self.to_html(compiled_source)
      #Redcarpet::Markdown.new(Markerb.renderer, Markerb.processing_options).render(compiled_source)
      compiled_source
    end

    def self.to_text(compiled_source)
      compiled_source
    end
  end
end
