# MultipartErb [![Build Status](https://travis-ci.org/econsultancy/multiparterb.svg?branch=master)](https://travis-ci.org/econsultancy/multiparterb) [![Gem Version](https://badge.fury.io/rb/multiparterb.svg)](http://badge.fury.io/rb/multiparterb)

**MultipartErb** allows you to render multipart e-mails from a single template.

The template is written in HTML with a reduced set of HTML elements,
which is then parsed and formatted through user provided formatters,
which then renders and delivers as both text and HTML parts.

## Installation

Add it into your `Gemfile`

```ruby
gem 'multiparterb'
```

Install it

```console
bundle install
```

## Usage

### Templates

You create one erb template file written in HTML with a reduced set of elements.

Example `app/views/notifier/contact.multipart` :

```erb
<h1>Heading with a link to <a href="https://example.com">Example</a></h1>
<p>body with a link to <a href="https://econsultancy.com">Econsultancy</a></p>
<a href="http://example.com">a link with a <h1>heading</h1> in</a>
```

### Formatters

You then have to create and provide one or more formatters for MultipartErb to call on each element it finds.

This is derived from a base class `BaseFormatter` provided by MultipartErb, any undefined methods that get called will raise a `NotImplementedError`.

This example formats the elements as it finds them, standard HTML output. _(TODO: Maybe provide this as standard?)_

```ruby
class MyHTMLFormatter < MultipartErb::BaseFormatter
  def heading(text)
    content_tag(:h1, text)
  end

  def paragraph(text)
    content_tag(:p, text)
  end

  def anchor(text, href)
    content_tag(:a, text, href: href)
  end
end
```

And here is an example text formatter.

```ruby
class MyTextFormatter < MultipartErb::BaseFormatter
  def heading(text)
    "*** #{text} ***\n"
  end

  def paragraph(text)
    text
  end

  def anchor(text, href)
    text + ' (' + href + ')'
  end
end
```

Then you need to tell MultipartErb which formatters you want it to use.

```ruby
# ./config/initializers/multiparterb.rb
MultipartErb.html_formatter = MyHTMLFormatter.new
MultipartErb.text_formatter = MyTextFormatter.new
```

It will then call the relevent method for each element it finds in the template.

The set of elements this currently supports, and the method that will get called are :

* `<h1></h1>` => `Formatter#heading`
* `<p></p>` => `Formatter#htext`
* `<a href="https://example.com">example</a>` => `Formatter#hanchor`
* `<ul></ul>` => `Formatter#unordered_list`
* `<li></li>` => `Formatter#list_item`

### Mailers

Then your mailers work as normal, and you still get control over which parts you want generated :

```ruby
class Notifier < ActionMailer::Base
  def contact(recipient)
    @recipient = recipient
    mail(:to => @recipient, :from => "john.doe@example.com") do |format|
      format.text
      format.html
    end
  end
end
```

It will generate two parts, one in text and another in html when delivered.

If you only wanted to text or html part, then just remove the `format` you don't want.

### Output

For the above given example, the resulted output would be as such :

Text version

```
*** Heading with a link to Econsultancy (https://econsultancy.com) ***
body with a link to Econsultancy (https://econsultancy.com)
a link with a *** heading *** in (http://example.com)"
```

Html version

```
<h1>Heading with a link to <a href=\"https://econsultancy.com\">Econsultancy</a></h1>
<p>body with a link to <a href=\"https://econsultancy.com\">Econsultancy</a></p>
<a href=\"http://example.com\">a link with a <h1>heading</h1> in</a>
```

## Notes

* The `contact.multipart` template should not have a format in its name. Adding a format would make it unavailable to be rendered in different formats;

* You can use ERb inside the template, which gets parsed before the formatting occurs.

## Bug reports

If you discover any bugs, feel free to create an issue on GitHub. Please add as much information as
possible to help us fixing the possible bug. We also encourage you to help even more by forking and
sending us a pull request.

https://github.com/econsultancy/multiparterb/issues

## Maintainers

* Ian Vaughan (https://github.com/IanVaughan)

## Thanks

This gem was derived from [Markerb](https://github.com/plataformatec/markerb).

## License

MIT License. Copyright 2011-2014 Econsultancy
