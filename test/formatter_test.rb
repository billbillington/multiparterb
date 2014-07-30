require "test_helper"

# TODO: The idea will be to require the user to provide this as a callback
class FormatterTest < ActiveSupport::TestCase
  test 'a format' do
    assert_equal "test", MultipartErb::Formatter.to_html("test").strip
  end
end
