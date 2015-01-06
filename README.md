# SVG ❤’s You

SVG that you can target with CSS is really great for icons and fun illustrations, but it can be a big headache to get into the DOM from a file made in an editor. It becomes even more clumsy when you want to tweak that file back in a vector image editor and then have to re-copy everything back into the appropriate places. I got sick of doing this, so I created this gem to help include SVG files at the view level.

**SVG ❤’s You** provides methods to help inline, symbolize, and externally `<use>` SVG files. It pulls in files and parses them so that you can still edit them and simply refresh the page to see the updated SVG code in your browser.

Seriously, stop copy/pasting SVG text.


## Installation

Add this line to your application's Gemfile:

```
gem 'svg_hearts_you'
```

And then execute:

```
$ bundle
```

Or install on your machine with:

```
$ gem install svg_hearts_you
```

## Configuration

In a Rails app, **SVG ❤’s You** is already configured to use the app's  `image_paths` by default. In Middleman, **SVG ❤’s You** uses `images_dir` by
default.

If you are in another environment or want to add custom search paths, you can configure the gem by the adding to the svg_paths array in the gem's configuration like so:

```
SvgHeartsYou.configure do |config|
  config.svg_paths << '/some/path/here'
  # or
  config.svg_paths += ['/one/path', '/two/path']
end
```



## Usage

**SVG ❤’s You** provides the following helper methods. These methods are automatically exposed to views in Rails and Middleman. In other environments, use the class methods on the SvgHeartsYou module (i.e. `SvgHeartsYou.svg_use 'hello'`).

---

### `svg_inline(filename, options={})`

Quickly inline a svg from a given file. It searches the configured `svg_paths` for a filename, otherwise throws a runtime error on file not found. Any attributes provided are placed as attributes on the `<svg>` tag.

#### Usage (ERB)

```
<%= svg_inline 'circle', id: 'my-pretty-circle', class: 'logo' %>
```

#### Output

```
<svg id="my-pretty-circle" class="logo" (existing attributes in file...)>
   <!-- Contents of circle.svg file -->
</svg>
```

---

### `svg_symbol(filenames, options={})`

Takes a single filename (string) or list of filenames (list of strings) and converts all the given svg files into symbols within one svg tag. This is useful for reuse in the document with the `<use>` tag (see `svg_use` below). Chris Coyier wrote a [very useful guide](http://css-tricks.com/svg-symbol-good-choice-icons/) about using symbols.

Takes a hash of parameters. The specified keys in the hash change behavior, all
other keys are added as parameters to the parent `<svg>` tag.

* `:folder` — If set to true, the method will look for a folder(s) and symbolize
  all svg files within it(them). Each symbol tag will have the `id` attribute
  set to the original file name of each svg file.
* `:each` — If this is set to a hash, all key-value pairs passed in will appear
  as attributes on each `<symbol>` tag.
* `&block` — A block can be supplied that is given an `attributes` object that
  contains the attributes for each symbol tag. Any modifications to this hash
  will be output to the final `<symbol>` tag. See example #4 below.


#### Usage (ERB)

```
<!-- 1 -->
<%= svg_symbol 'circle', class: 'shapes' %>

<!-- 2 -->
<%= svg_symbol ['circle', 'square'], class: 'shapes', each: {class: 'shape'} %>

<!-- 3 -->
<!-- folder contains circle.svg, square.svg, and triangle.svg -->
<%= svg_symbol 'all-my-shapes', folder: true %>

<!-- 4 -->
<%= svg_symbol 'all-my-shapes', folder: true do |attributes| %>
  <% attributes[:class] = 'shape' %>
  <% attributes[:id] = attributes[:id] + '-logo' %>
<% end %>
```

#### Output

```
<!-- 1 -->
<svg class="shapes">
  <symbol id="circle" (existing attributes on circle.svg <svg> tag...)>
    <!-- Contents of circle.svg file -->
  </symbol>
</svg>


<!-- 2 -->
<svg class="shapes">
  <symbol id="circle" class="shape" ...)>
    <!-- Contents of circle.svg file -->
  </symbol>
  <symbol id="square" class="shape" ...)>
    <!-- Contents of square.svg file -->
  </symbol>
</svg>

<!-- 3 -->
<svg>
  <symbol id="circle" ...>
    <!-- Contents of circle.svg file -->
  </symbol>
  <symbol id="square" ...>
    <!-- Contents of square.svg file -->
  </symbol>
  <symbol id="triangle" ...>
    <!-- Contents of triangle.svg file -->
  </symbol>
</svg>


<!-- 4 -->
<svg>
  <symbol id="circle-logo" class="shape" ...>
    <!-- Contents of circle.svg file -->
  </symbol>
  <symbol id="square-logo" class="shape" ...>
    <!-- Contents of square.svg file -->
  </symbol>
  <symbol id="triangle-logo" class="shape" ...>
    <!-- Contents of triangle.svg file -->
  </symbol>
</svg>
```



---

### `svg_use(id, options={})`

Helper method to use a previously defined symbol by using it's id (typically it's filename unless you modified it). You can also target symbols in external files, which is great for cacheablility. Unfortunately, IE and old Android browsers can't handle `<use>` tags with external sources, but [there's a polyfill for that](https://github.com/jonathantneal/svg4everybody). Chris Coyier [covered this in more detail](http://css-tricks.com/svg-use-external-source/).


#### Usage (ERB)

```
<!-- 1 & 2 -->
<%= svg_use 'circle', class: 'logo' %>
<!-- or -->
<%= svg_use '#circle', class: 'logo' %>

<!-- 3 -->
<%= svg_use 'my-external-symbols.svg#circle' %>

```

#### Output

```
<!-- 1 & 2 -->
<svg class="logo" version="1.1" xmlns="http://www.w3.org/2000/svg">
  <use xlink:href="#circle">
</svg>

<!-- 3 -->
<svg version="1.1" xmlns="http://www.w3.org/2000/svg">
  <use xlink:href="my-external-symbols.svg#circle">
</svg>
```

---

## Thoughts, some use cases, and further reading

If you have got this far and haven't seen Chris Coyier's articles on using SVG
for icons as symbols, I recommend looking at them.

1. http://css-tricks.com/svg-symbol-good-choice-icons/
1. http://css-tricks.com/svg-use-external-source/
1. http://css-tricks.com/gotchas-on-getting-svg-into-production/

If you are like me and don't want to think,  `svg_inline` is dead simple to inline a file into the page. This gives you the most control and is the simplest to understand. The big drawback is that it can be a lot of markup to copy into your document that can't be cached. Best to use this if you need absolute control over some illustration with CSS.

If you are going to reuse the same icon on a page, take advantage of svg `<symbol>`. It allows you to reuse the same SVG content multiple times without
the bloat of copying the same markup. The `svg_symbol` and `svg_use` functions should make this pretty simple. CSS styling does have a few gotchas when you
are using `<use>`, so make sure to see [CSS tricks article about all the gotchas](http://css-tricks.com/gotchas-on-getting-svg-into-production/).




Even better—make an external file with each svg file as a symbol. The `svg_symbol` function can be used with sprockets to prep a file of
symbols (that can be externally used with the `<use>` tag.

You can create a new svg file that will be dynamically generated with ERB. For
example, a file named `my-symbols.svg.erb` with the following contents

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">

<%= svg_symbol ['each', 'folder', 'and/subfolder'], folder: true %>
```

creates one main file with symbols for each SVG file that can be used externally, like so:

```
<%= svg_use 'my-symbols.svg#circle' %>
```

This is pretty simple once it's set up, but unfortunately it needs [a polyfill](https://github.com/jonathantneal/svg4everybody)
to work with IE and old Android browsers.


## Contributing

### Basics

1. [Fork it]( https://github.com/pknb/svg_hearts_you/fork )
1. Create your feature branch (`git checkout -b my-new-feature`)
1. Commit your changes (`git commit -am 'Add some feature'`)
1. Push to the branch (`git push -u origin my-new-feature`)
1. When finished, [squash commits (easiest into new branch)](https://github.com/ginatrapani/todo.txt-android/wiki/Squash-All-Commits-Related-to-a-Single-Issue-into-a-Single-Commit)
    * Example (*from feature branch*)
        * `git checkout -b 'my-new-feature-squashed'`
        * `git rebase -i HEAD~#` (Squash # commits, changing # to real value)
        * Push up the new branch
1. Create a new Pull Request with squashed branch

**Make sure** all tests pass with `bundle exec rake test`, and add appropriate
tests for whatever additions you add. Currently Middleman functionality is
tested through cucumber features and fixtures, taking advantage of step
definitions in `middleman-core`. Unit tests and rails feature tests are in
`spec`. The rails features use a dummy rails app for testing under
`spec/rails/dummy`. If you want to just try stuff out in the console, there is
a rake tast that loads the gem definition into an `irb` session. Just run
`bundle exec rake console`.

There is no formal style guide, but please try to stick with the current code
style—2 space indents, only one new line at end of file, etc.
