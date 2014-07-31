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
  # </ul>

  class Formatter
    def self.parse(text, formatter)
      result = ""
      html_doc = Nokogiri::HTML text

      if heading = html_doc.at_css('h1')
        result << formatter.email_heading(heading.content)
      end
      if heading = html_doc.at_css('p')
        result << formatter.email_text(heading.content)
      end
      if heading = html_doc.at_css('a')
        result << formatter.anchor(
          heading.content,
          heading.attributes['href'].content
        )
      end
      if heading = html_doc.at_css('ul')
        result << formatter.unordered_list(heading.content)
      end
      result
    end

    def self.to_html(compiled_source)
      parse compiled_source, MultipartErb.html_formatter
    end

    def self.to_text(compiled_source)
      parse compiled_source, MultipartErb.text_formatter
    end
  end
end
