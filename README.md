# Rust Playground Highlight Blocks

Automatically add links to the Rust Playground for code samples in your Jekyll site, so that they look like this:

<img src="http://i.imgur.com/gkFQsHJ.png" />

## Usage

You can link two different kinds of Rust Playground pages -- dynamically generated & gist generated

### Dynamically Generated

The content of your block appears in the Rust Playground exactly as it appears. This takes advantage of Rust Playground's support for displaying code via URL query strings.

The advantage of this approach is that you only have to type your Rust code once. The code in your highlight block appears exactly as is in the Playground.

### Use
If you wrap a block of Rust code in rp_highlight tags, like this

```
{% rp_highlight rust %}
fn main() {
  println!("{}", "Rust Is Memory Safe!"};
}
{% endrp_highlight %}
```

This will be rendered like a normal HighlightBlock, but with the addition of a "Run" button that links to a Rust Playground page with your code.

The code above would link to a playground page [like this](https://play.rust-lang.org/?code=fn+main%28%29+%7B%0A++println!%28"%7B%7D","Rust%20is%20Memory%20Safe!"%29%3B%0A%7D&version=stable)

# Gist Generated

The Rust Playground can also display code that is in a Gist. You can use the Gist ID to create a Rust Playground link for your code block:

```
{% rp_highlight rust gist_id=cc6e026b0654a4216074 %}
  println!("{}", "Rust Is Memory Safe!"};
}
{% endrp_highlight %}
```

With Gist Generated blocks only the code in the Gist is displayed in the Playground. The code in your block is ignored. This is nice if you want to only display a small section of code in your block, but you want the full version of the code to be in the Playground.

In the example above, I've left the `main` function out of the sample code, but it is present in the [Playground](https://play.rust-lang.org/?gist=cc6e026b0654a4216074&version=stable)

## Output

```html
<code>
  <pre>
    /*your sweet Rust code*/
  </pre>
  <a href='https://play.rust-lang.org/...' target='_new' class='playground btn btn-xs btn-primary active' role='button'>Run</a>
</code>
```
Thus plugin does not change how the code is rendered, it only inserts the link button between the `</pre>` and `</code>` tags.

Styling and positioning the button is up to you. No CSS is provided with this plugin. The CSS used in my example screenshot is:

```css
.highlight div.playground {
  text-align: right;
  outline: none;
  padding: 6px;
}

.highlight a.playground-btn {
  border: 1px solid #555;
  padding-left: 8px;
  padding-right: 8px;
  padding-top: 2px;
  padding-bottom: 2px;
  background-color: #eee;
  color:#555;

}
```

## Installation

In your Gemfile, add

```
gem 'rust_playground_highlight', :require => 'rust_playground_highlight'
```

Then run `bundle`

In your `_plugins` directory (which you can create, if you don't have one), add the file `bundler.rb` with the content:

```
# _plugins/bundler.rb
require "rubygems"
require "bundler/setup"
Bundler.require(:default)
```

## Requirements
- I am using this with Jekyll 2.5.3. It *should* work with Jekyll 3.
- The CSS classes on the button assume you have Bootstrap.

## Limitations

- Links always point to the stable Rust channel. Support for Beta or Nightly would be nice.

