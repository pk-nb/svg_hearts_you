# SvgHeartsYou

TODO: Write a gem description



## Usage

## Installation

Add this line to your application's Gemfile:

    gem 'svg_hearts_you'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install svg_hearts_you

TODO: Write usage instructions here

## Contributing

1. Fork it ( https://github.com/[my-github-username]/svg_hearts_you/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request


### Updating

This gem uses the SVG for Everybody gem to polyfill IE and Android devices when
`svg_use` is set to use external sources.

The gem is included as a separate branch and using [subtree merging](http://git-scm.com/book/en/v1/Git-Tools-Subtree-Merging).
To update the gem, run the following commands:

#### (First time) Creating local branch to pull svg4everybody gem

```
git remote add svg_for_everybody_remote https://github.com/jonathantneal/svg4everybody.git
git fetch svg_for_everybody_remote
git checkout -b svg_for_everybody_branch svg_for_everybody_remote/master
```

#### Updating gem and merging

```
git checkout svg_for_everybody_branch
git pull
git checkout master
git merge --squash -s subtree --no-commit svg_for_everybody_branch

```
