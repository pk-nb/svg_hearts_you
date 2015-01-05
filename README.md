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

### > `svg_inline(filename, options={})`

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

### > `svg_symbol(filenames*, options={})`

Takes a set of filenames and converts all the svg files into symbols within one
svg for reuse in the document.

#### Usage (ERB)

```
<!-- 1 -->
<%= svg_symbol 'circle', 'square', class: 'shapes' %>

<!-- 2 -->
<!-- folder contains circle.svg, square.svg, and triangle.svg -->
<%= svg_symbol 'all-my-shapes', folder: true %>

<!-- 3 -->
<%= svg_symbol 'all-my-shapes', folder: true do |symbol, attributes| %>
  <%= symbol id: attributes.id + '-logo', class: 'shape' %>
<% end %>
```

#### Output

```
<!-- 1 -->

<svg class="shapes">
  <symbol id="circle" (existing attributes on circle.svg <svg> tag...)>
    <!-- Contents of circle.svg file -->
  </symbol>
  <symbol id="square" (existing attributes on square.svg <svg> tag...)>
    <!-- Contents of square.svg file -->
  </symbol>
</svg>

<!-- 2 -->
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


<!-- 3 -->
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
