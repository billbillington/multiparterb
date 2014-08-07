require "test_helper"

class BaseFormatterTest < ActiveSupport::TestCase
  setup do
    TestFormatter = Class.new(MultipartErb::BaseFormatter)
    MultipartErb.html_formatter = TestFormatter.new
  end

  teardown do
    MultipartErb.html_formatter = MyHTMLFormatter.new
  end

  test 'missing required formatter method' do
    exception = assert_raises NoMethodError do
      MultipartErb::Formatter.to_html('<h1>heading</h1>')
    end
    assert_equal "undefined method `heading' for #{MultipartErb.html_formatter}", exception.message
  end
end
