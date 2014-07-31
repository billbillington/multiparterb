require "action_view"
require "action_view/template"
require "multiparterb/formatter"
require "multiparterb/railtie"
require "multiparterb/formatters/base_formatter"
require "multiparterb/formatters/html_formatter"
require "multiparterb/formatters/text_formatter"

require 'nokogiri'

module MultipartErb
  class Handler
    def erb_handler
      @erb_handler ||= ActionView::Template.registered_template_handler(:erb)
    end

    def call(template)
      compiled_source = erb_handler.call(template)

      if template.formats.include?(:html)
        "MultipartErb::Formatter.to_html(begin;#{compiled_source};end).html_safe"
      else
        "MultipartErb::Formatter.to_text(begin;#{compiled_source};end).html_safe"
      end
    end
  end
end

ActionView::Template.register_template_handler(:multipart, MultipartErb::Handler.new)
