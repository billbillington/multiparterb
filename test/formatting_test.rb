require "test_helper"

class FormattingTest < ActiveSupport::TestCase
  setup do
  end

  test 'a format' do
    assert_equal "<p>Dual templates <strong>rocks</strong>!</p>", MultipartErb::Multipart.to_html("Dual templates **rocks**!").strip
  end
end
