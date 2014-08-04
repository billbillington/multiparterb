class MyHTMLFormatter < MultipartErb::BaseFormatter
  def heading(text)
    content_tag(:h1, text)
  end

  def text(text)
    content_tag(:p, text)
  end

  def anchor(text, href)
    content_tag(:a, text, href: href)
  end
end
