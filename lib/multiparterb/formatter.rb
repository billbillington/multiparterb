module MultipartErb
  mattr_accessor :html_formatter, :text_formatter
  @@html_formatter = nil
  @@text_formatter = nil

  SUPPORTED_TAG_METHODS = {
    # HTML tag => method called
    'h1' => :heading,
    'p' => :paragraph,
    'ul' => :unordered_list,
    'li' => :list_item,
    'strong' => :strong,
    'a' => :anchor,
  }

  class Formatter
    def self.parse(node, formatter)
      "".tap do |result|
        node.children.each do |child|
          result << lookup(child, formatter)
        end
      end
    end

    def self.lookup(child, formatter)
      return child.text if child.name == 'text'
      parsed_text = parse(child, formatter).html_safe

      if SUPPORTED_TAG_METHODS.keys.include?(child.name)
        if child.name == 'a'
          formatter.public_send(SUPPORTED_TAG_METHODS[child.name], parsed_text, child.attributes['href'].content)
        else
          formatter.public_send(SUPPORTED_TAG_METHODS[child.name], parsed_text)
        end
      else
        parsed_text
      end
    end

    def self.to_html(compiled_source)
      html_doc = Nokogiri::HTML(compiled_source)
      parse(html_doc, MultipartErb.html_formatter)
    end

    def self.to_text(compiled_source)
      html_doc = Nokogiri::HTML(compiled_source)
      parse(html_doc, MultipartErb.text_formatter)
    end
  end
end
