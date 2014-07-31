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
    text + "\n" + ("-" * text.length) + "\n"
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

    @template = formatted_html_output %{
      <h1>Heading with a link to <a href="https://econsultancy.com">Econsultancy</a></h1>
      <p>body with a link to <a href="https://econsultancy.com">Econsultancy</a></p>
      <a href="http://example.com">a link with a <h1>heading</h1> in</a>
    }
  end

  test 'formatted html output' do
    html = formatted_html_output %{
      <h1>Heading with a link to <a href=\"https://econsultancy.com\">Econsultancy</a></h1>
      <p>body with a link to <a href=\"https://econsultancy.com\">Econsultancy</a></p>
      <a href=\"http://example.com\">a link with a <h1>heading</h1> in</a>
    }
    assert_equal html, MultipartErb::Formatter.to_html(@template).strip
  end

  test 'formatted text output' do
    text = "Heading with a link to Econsultancy (https://econsultancy.com)
--------------------------------------------------------------
body with a link to Econsultancy (https://econsultancy.com)
a link with a heading
-------
 in (http://example.com)"
    assert_equal text, MultipartErb::Formatter.to_text(@template).strip
  end
end
