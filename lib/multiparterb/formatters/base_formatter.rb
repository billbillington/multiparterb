#module MultipartErb
  class BaseFormatter
    include ActionView::Helpers::TagHelper
    include ActionView::Context

    def email_heading(text)
      raise NotImplementedError
    end

    # TODO: rename email_body
    def email_text(text=nil, &block)
      text || capture(&block)
    end
  end
#end
