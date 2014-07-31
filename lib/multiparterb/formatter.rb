module MultipartErb
  mattr_accessor :html_formatter, :text_formatter
  @@html_formatter = nil
  @@text_formatter = nil

  # Template Format
  #
  # <h1>This is a heading</h1>            #=> email_heading
  #
  # <p>Normal paragraph tag</p>           #=> email_text
  #
  # <ul>
  #   <li>This is a list</li>
  #   <li><a href='foo'><\a><is a list</li>
  # </ul>
  #
  #
  # Does not handle nested attributes within a href elements
  # <a href="https://econsultancy.com">Econsultancy</a>
  #

  class Formatter
    def self.parse(node, formatter)
      result = ""

      node.children.each do |child|
        case child.name
        when 'h1'
          result << formatter.email_heading(parse(child, formatter).html_safe)
        when 'p'
          result << formatter.email_text(parse(child, formatter).html_safe)
        when 'a'
          result << formatter.anchor(
            child.text,
            child.attributes['href'].content)
        when 'text'
          result << child.text
        else
          result << parse(child, formatter)
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
