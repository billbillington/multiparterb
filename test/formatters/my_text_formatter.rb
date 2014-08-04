class MyTextFormatter < MultipartErb::BaseFormatter
  def heading(text)
    text + "\n" + ("-" * text.length) + "\n"
  end

  def text(text)
    text
  end

  def anchor(text, href)
    text + ' (' + href + ')'
  end
end
