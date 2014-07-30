module MultipartErb
  mattr_accessor :processing_options, :renderer

  class Multipart
    def self.to_html(compiled_source)
      #Redcarpet::Markdown.new(Markerb.renderer, Markerb.processing_options).render(compiled_source)
    end
  end
end
