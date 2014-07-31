#module MultipartErb
  class HTMLFormatter < BaseFormatter
    # Gives you the correct formatting for a heading/intro text
    # with the blank cell padding after it
    def email_heading(text)
      content_tag :h1, text
    end

    # Gives you the normal body text when a blank cell padding after
    def email_text(text=nil, &block)
      content_tag :p, super
    end
  end
#end
