require "test_helper"

class Notifier < ActionMailer::Base
  self.view_paths = File.expand_path("../views", __FILE__)

  layout false

  def contact(recipient, format_type)
    @recipient = recipient
    mail(:to => @recipient, :from => "john.doe@example.com") do |format|
      format.send(format_type)
    end
  end

  def link(format_type)
    mail(:to => "foo@bar.com", :from => "john.doe@example.com") do |format|
      format.send(format_type)
    end
  end

  def welcome
    mail do |format|
      format.html
      format.text
    end
  end

  def user(format_type)
    mail(:to => "foo@bar.com", :from => "john.doe@example.com") do |format|
      format.send(format_type)
    end
  end

  def multiple_format_contact(recipient)
    @recipient = recipient
    mail(:to => @recipient, :from => "john.doe@example.com", :template => "contact") do |format|
      format.text  { render "contact" }
      format.html  { render "contact" }
    end
  end
end

class MultipartErbTest < ActiveSupport::TestCase
  test "plain text should be sent as a plain text" do
    email = Notifier.contact("you@example.com", :text)
    assert_equal "text/plain", email.mime_type
    assert_equal false, email.multipart?
    assert_equal "Contact Heading\n---------------\n\n", email.body.raw_source
  end

  test "html should be sent as html" do
    email = Notifier.contact("you@example.com", :html)
    assert_equal "text/html", email.mime_type
    assert_equal false, email.multipart?
    assert_equal "<h1>Contact Heading</h1>", email.body.encoded.strip
  end

  test "dealing with multipart e-mails" do
    email = Notifier.multiple_format_contact("you@example.com")
    assert_equal 2, email.parts.size
    assert_equal true, email.multipart?
    assert_equal "multipart/alternative", email.mime_type
    assert_equal "text/plain", email.parts[0].mime_type
    assert_equal "Contact Heading\n---------------\n\n", email.parts[0].body.raw_source
    assert_equal "text/html", email.parts[1].mime_type
    assert_equal "<h1>Contact Heading</h1>", email.parts[1].body.encoded.strip
  end

  test "format order is not important and default markup is text" do
    email = Notifier.welcome
    assert_equal 2, email.parts.size
    assert_equal true, email.multipart?
    assert_equal "multipart/alternative", email.mime_type
    assert_equal "text/plain", email.parts[0].mime_type
    assert_equal "Welcome\n\n", email.parts[0].body.raw_source
    assert_equal "text/html", email.parts[1].mime_type
    assert_equal "<p>Welcome\r\n</p>", email.parts[1].body.encoded.strip
  end

  test "with link" do
    email = Notifier.link(:html)
    assert_equal "text/html", email.mime_type
    assert_equal "<p>A link to <a href=\"https://econsultancy.com\">Econsultancy</a></p>", email.body.encoded.strip
  end

  test "with partial" do
    email = Notifier.user(:html)
    assert_equal "text/html", email.mime_type
    assert_equal "<p>User template rendering a partial </p><p>User Info Partial</p>", email.body.encoded.strip
  end
end
