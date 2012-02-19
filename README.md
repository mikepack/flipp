# flipp

To alleviate issues around highly divergent development databases on feature/refactor branches, flipp helps switch databases upon new branch checkouts.

# Database Support

Current support is for MySQL only.

# Installation & Usage

1. Add `gem 'flipp'` to your Gemfile or do `gem install flipp`.
2. Run `rake flipp:install` from your project's root directory to install the git hook
3. Normal git workflow, ie. switch branches normally

# License

flipp is released under the MIT license