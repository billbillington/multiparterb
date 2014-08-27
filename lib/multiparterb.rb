require "action_view"
require "action_view/template"
require "multiparterb/formatter"
require "multiparterb/railtie"
require "multiparterb/formatters/base_formatter"

require 'nokogiri'

module MultipartErb
  class Handler
    def erb_handler
      @erb_handler ||= ActionView::Template.registered_template_handler(:erb)
    end

    def call(template)
      compiled_source = erb_handler.call(template)
      return compiled_source if partial?(template)

      if template.formats.include?(:html)
        "MultipartErb::Formatter.to_html(begin;#{compiled_source};end).html_safe"
      elsif template.formats.include?(:text)
        "MultipartErb::Formatter.to_text(begin;#{compiled_source};end).html_safe"
      else
        compiled_source
      end
    end

    def partial?(template)
      File.basename(template.inspect)[0] == '_'
    end
  end
end

ActionView::Template.register_template_handler(:multipart, MultipartErb::Handler.new)
ActionView::Template.register_template_handler(:multiparterb, MultipartErb::Handler.new)
