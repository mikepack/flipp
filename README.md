# flipp

To alleviate issues around highly divergent development databases on feature/refactor branches, flipp helps unobtrusively switch databases upon new branch checkouts.

# Database Support

Current support is for MySQL only.

# Installation & Usage

1. Add `gem 'flipp'` to your Gemfile or do `gem install flipp`.
2. Normal git workflow, ie. switch branches normally

# Uninstall

1. Remove the 'flipp' gem from your Gemfile.
2. Your unaltered development database is used.

# License

flipp is released under the MIT license