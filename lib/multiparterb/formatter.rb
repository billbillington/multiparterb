module MultipartErb
  mattr_accessor :html_formatter, :text_formatter
  @@html_formatter = nil
  @@text_formatter = nil

  class Formatter
    def self.parse(node, formatter)
      result = ""

      node.children.each do |child|
        result << case child.name
                  when 'h1'
                    formatter.email_heading(parse(child, formatter).html_safe)
                  when 'p'
                    formatter.email_text(parse(child, formatter).html_safe)
                  when 'a'
                    formatter.anchor(
                      parse(child, formatter).html_safe,
                      child.attributes['href'].content)
                  when 'text'
                    child.text
                  else
                    parse(child, formatter)
                  end
      end

      result
    end

    def self.to_html(compiled_source)
      html_doc = Nokogiri::HTML compiled_source
      parse html_doc, MultipartErb.html_formatter
    end

    def self.to_text(compiled_source)
      html_doc = Nokogiri::HTML compiled_source
      parse html_doc, MultipartErb.text_formatter
    end
  end
end
