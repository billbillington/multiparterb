require "test_helper"

# TODO: The idea will be to require the user to provide this as a callback
class FormattingTest < ActiveSupport::TestCase
  test 'a format' do
    assert_equal "<p>Dual templates <strong>rocks</strong>!</p>", MultipartErb::Multipart.to_html("Dual templates **rocks**!").strip
  end
end
