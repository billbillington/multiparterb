class MyHTMLFormatter < BaseFormatter
  def email_heading(text)
    content_tag :h1, text
  end

  def email_text(text=nil, &block)
    content_tag :p, super
  end

  def anchor(text, href)
    content_tag(:a, text, href: href)
  end
end
