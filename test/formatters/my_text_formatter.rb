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

  def unordered_list(text)
    text
  end

  def list_item(text)
    "- #{text}"
  end
end
