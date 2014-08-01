require "test_helper"
require "generators/multiparterb/mailer/mailer_generator"

class GeneratorTest < Rails::Generators::TestCase
  tests MultipartErb::Generators::MailerGenerator
  destination File.expand_path("../tmp", __FILE__)
  setup :prepare_destination

  test "assert all views are properly created with given name" do
    run_generator %w(notifier foo bar baz)

    assert_file "app/views/notifier/foo.multipart"
    assert_file "app/views/notifier/bar.multipart"
    assert_file "app/views/notifier/baz.multipart"
  end
end
