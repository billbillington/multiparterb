require "test_helper"

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

class MyTextFormatter < BaseFormatter
  def email_heading(text)
    text + "\n"
  end

  def email_text(text=nil, &block)
    text + "\n"
  end

  def anchor(text, href)
    text + ' (' + href + ')'
  end
end

# TODO: The idea will be to require the user to provide this as a callback
class FormatterTest < ActiveSupport::TestCase
  setup do
    MultipartErb.html_formatter = MyHTMLFormatter.new
    MultipartErb.text_formatter = MyTextFormatter.new

    @template = "<h1>Heading</h1><p>body with a link to <a href='https://econsultancy.com'>Econsultancy</a></p>"
  end

  test 'formatted html output' do
    assert_equal "<h1>Heading</h1><p>body with a link to <a href=\"https://econsultancy.com\">Econsultancy</a></p>", MultipartErb::Formatter.to_html(@template).strip
  end

  test 'formatted text output' do
    assert_equal "Heading\nbody with a link to Econsultancy (https://econsultancy.com)", MultipartErb::Formatter.to_text(@template).strip
  end
end
