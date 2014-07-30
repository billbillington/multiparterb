require "action_view"
require "action_view/template"
require "multiparterb/multipart"
require "multiparterb/railtie"

module MultipartErb
  class Handler
    def erb_handler
      @erb_handler ||= ActionView::Template.registered_template_handler(:erb)
    end

    def call(template)
      compiled_source = erb_handler.call(template)
      if template.formats.include?(:html)
        # output HTML
        "MultipartErb::Multipart.to_html(begin;#{compiled_source};end).html_safe"
      else # text
        # output text
        "MultipartErb::Multipart.to_text(begin;#{compiled_source};end).html_safe"
      end
    end
  end
end

ActionView::Template.register_template_handler :multipart, MultipartErb::Handler.new
