require 'pry'

require "minitest/autorun"
require "active_support/test_case"

require "action_mailer"
require "rails/railtie"
require "rails/generators"
require "rails/generators/test_case"

$:.unshift File.expand_path("../../lib", __FILE__)
require "multiparterb"

# Avoid annoying warning from I18n.
I18n.enforce_available_locales = false
