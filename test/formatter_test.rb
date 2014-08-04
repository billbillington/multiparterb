require "test_helper"

class FormatterTest < ActiveSupport::TestCase
  setup do
    @template = File.read('./test/views/formatter/formatter.multipart')
  end

  test 'formatted html output' do
    html = File.read('./test/views/formatter/formatter.html')
    assert_equal html, MultipartErb::Formatter.to_html(@template)
  end

  test 'formatted text output' do
    text = File.read('./test/views/formatter/formatter.text')
    assert_equal text, MultipartErb::Formatter.to_text(@template)
  end
end
