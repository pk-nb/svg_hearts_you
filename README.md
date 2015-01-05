# Gem incomplete, almost ready for submission.

---

# SVG ❤’s You

A heartwarming gem to help inline, symbolize, or externally `<use>` SVG files
at the view level. SVG ❤’s You provides several helper methods for both inlining
and symbolizing SVG

Stop copy/pasting SVG text.



## Installation

Add this line to your application's Gemfile:

```
gem 'svg_hearts_you'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install svg_hearts_you
```

## Usage

SVG ❤’s You provides the following helper methods.

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

Takes a single filename or list of filenames and converts all the given svg
files into symbols within one svg tag. This is useful for reuse in the document
with the `<use>` tag (see `svg_use` below).

Takes a hash of parameters. The specified keys in the hash change behavior, all
other keys are added as parameters to the parent `<svg>` tag.

* `:folder` — If set to true, the method will look for a folder(s) and symbolize
  all svg files within it(them). Each symbol tag will have the `id` attribute
  set to the original file name of each svg file.
* `:each` — If this is set to a hash, all key-value pairs passed in will appear
  as attributes on each `<symbol>` tag.


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

Make sure all tests pass with `bundle exec rake test`, and add appropriate tests
for whatever additions you add. Currently Middleman functionality is tested
through cucumber features and fixtures, taking advantage of step definitions
in `middleman-core`. Unit tests and rails feature tests are in `spec`. The rails
features use a dummy rails app for testing under `spec/rails/dummy`.
