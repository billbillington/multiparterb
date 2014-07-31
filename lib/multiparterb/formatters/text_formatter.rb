#module MultipartErb
  class TextFormatter < BaseFormatter
    # Gives you the correct formatting for a heading/intro text
    # with the blank cell padding after it
    def email_heading(text)
      text
    end

    # Gives you the normal body text when a blank cell padding after
    def email_text(text=nil, &block)
      super
    end
  end
#end
