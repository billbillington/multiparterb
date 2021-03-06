class MyHTMLFormatter < MultipartErb::BaseFormatter
  def heading(text)
    content_tag(:h1, text)
  end

  def paragraph(text)
    content_tag(:h2, text)
  end

  def anchor(text, href)
    content_tag(:a, text, href: href)
  end

  def unordered_list(text)
    content_tag(:ul, text)
  end

  def list_item(text)
    content_tag(:li, text)
  end
end
