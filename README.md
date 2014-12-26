# SVG ❤’s You

A heartwarming gem to help inline, symbolize, or externally `<use>` SVG files
at the view level. SVG ❤’s You provides several helper methods for different SVG strategies It also includes the SVG4Everybody polyfill to include when using external `<use>`.

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


### Updating

This gem uses the SVG for Everybody gem to polyfill IE and Android devices when
`svg_use` is set to use external sources.

The gem is included as a separate branch and using [subtree merging](http://git-scm.com/book/en/v1/Git-Tools-Subtree-Merging).
To update the gem, run the following commands:

#### #1 (First time) Creating local branch to pull svg4everybody gem

```
git remote add svg_for_everybody_remote https://github.com/jonathantneal/svg4everybody.git
git fetch svg_for_everybody_remote
git checkout -b svg_for_everybody_branch svg_for_everybody_remote/master
```

#### #2 Updating gem and merging

Branch is already included through the `git read-tree` command, so all that's
needed to update is:

```
git checkout svg_for_everybody_branch
git pull
git checkout master
git merge --squash -s subtree --no-commit svg_for_everybody_branch
```

Then check, modify, etc and commit when ready. Fancy.
