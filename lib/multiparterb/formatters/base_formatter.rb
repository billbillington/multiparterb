class BaseFormatter
  include ActionView::Helpers::TagHelper
  include ActionView::Context

  def email_heading(text)
    raise NotImplementedError
  end

  def email_text(text=nil, &block)
    text || capture(&block)
  end

  def anchor(text, href)
    raise NotImplementedError
  end

  def unordered_list(text)
    raise NotImplementedError
  end
end
