module MultipartErb
  mattr_accessor :html_formatter, :text_formatter
  @@html_formatter = nil
  @@text_formatter = nil

  class Formatter
    def self.parse(node, formatter)
      "".tap do |result|
        node.children.each do |child|
          result << lookup(child, formatter)
        end
      end
    end

    def self.lookup(child, formatter)
      case child.name
      when 'h1'
        formatter.heading(parse(child, formatter).html_safe)
      when 'p'
        formatter.text(parse(child, formatter).html_safe)
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
