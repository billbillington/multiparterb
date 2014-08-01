require 'pry'

require "minitest/autorun"
require "active_support/test_case"

require "action_mailer"
require "rails/railtie"
require "rails/generators"
require "rails/generators/test_case"

$:.unshift File.expand_path("../../lib", __FILE__)
require "multiparterb"
require "formatters/my_text_formatter"
require "formatters/my_html_formatter"

# Avoid annoying warning from I18n.
I18n.enforce_available_locales = false

def formatted_html_output(text)
  text.gsub(/\n +/, '')
end

MultipartErb.html_formatter = MyHTMLFormatter.new
MultipartErb.text_formatter = MyTextFormatter.new
