class MyTextFormatter < BaseFormatter
  def email_heading(text)
    text + "\n" + ("-" * text.length) + "\n"
  end

  def email_text(text=nil, &block)
    text + "\n"
  end

  def anchor(text, href)
    text + ' (' + href + ')'
  end
end
