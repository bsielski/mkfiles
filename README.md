# Mkfiles

A gem for generating directories, subdirectiories and empty files automaticaly based on paths from a yaml file.

For now it doesn't delete any file but it will overwrite if there are any conflicts.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mkfiles'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mkfiles

## Usage

Reqiure module and method.

```ruby
require "mkfiles/generate_from_file"
```

Use it.

```ruby
Mkfiles.generate_from_file("sample.yml")
```

Put a path to your yml file. Pay attention for your current working directory if you are using relative start place in your yml file.

## Yaml files

The path to a yaml file must be passed as an argument for the script. It contains the start place path (for example "." for current dirrectory) and relative paths for all entries (directories, subdirectories and empty files) that will be created.

Start place can be relative or absolute.

Sub paths for directories and subdirectories must ended with "/".

Use "/" as the directory separator.

An example of yaml file

```
start_place: "."

sub_paths:
  - random_directory_341234213/
  - ewqrfsd.txt
  - vdfewre/fwewfevc.txt
  - qewasdsdf/sd23e2fv/wfe32gv/d322fvgd/
  - qewasdsdf/sd23e2fv/dwqqwdqwef/
  - New Folderr53453/New Folder44444574/new document63452.txt
```

## To do features

- CLI commands
- Template yml file generator

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).