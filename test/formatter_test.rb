require "test_helper"

# TODO: The idea will be to require the user to provide this as a callback
class FormatterTest < ActiveSupport::TestCase
  test 'formatted output' do
    assert_equal "test", MultipartErb::Formatter.to_html("<h1>test</h1>").strip
  end
end
