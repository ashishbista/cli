# Crystal CLI

Yet another Crystal library for building command-line interface applications.

[![Build Status](https://travis-ci.org/mosop/cli.svg?branch=master)](https://travis-ci.org/mosop/cli)

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  cli:
    github: mosop/cli
```

## Code Samples
<a name="code_samples"></a>

### Option Parser

```crystal
class Command < Cli::Command
  class Options
    string "--hello"
  end

  def run
    puts "Hello, #{options.hello}!"
  end
end

Command.run %w(--hello world) # prints "Hello, world!"
```

### Exit

```crystal
class Open < Cli::Command
  class Options
    arg "word"
  end

  def valid?
    args.word == "sesame"
  end

  def run
    if valid?
      exit! "Opened!"
    else
      error! "Not opened!"
    end
  end
end

Open.run %w(sesame) # => prints "Opened!" and returns 0
Open.run %w(paprika) # => prints "Not opened!" into STDERR and returns 1
```

### Subcommand

```crystal
class Polygon < Cli::Supercommand
  command "triangle", default: true

  class Triangle < Cli::Command
    def run
      puts 3
    end
  end

  class Square < Cli::Command
    def run
      puts 4
    end
  end

  class Hexagon < Cli::Command
    def run
      puts 6
    end
  end
end

Polygon.run %w(triangle) # prints "3"
Polygon.run %w(square)   # prints "4"
Polygon.run %w(hexagon)  # prints "6"
Polygon.run %w()         # prints "3"
```

### Aliasing

```crystal
class Command < Cli::Supercommand
  command "l", aliased: "loooooooooong"

  class Loooooooooong < Cli::Command
    def run
      sleep 1000
    end
  end
end

Command.run %w(l) # sleeps
```

### Inheritance

```crystal
abstract class Role < Cli::Command
  class Options
    string "--name"
  end
end

class Chase < Cli::Supercommand
  class Mouse < Role
    def run
      puts "#{options.name} runs away."
    end
  end

  class Cat < Role
    def run
      puts "#{options.name} runs into a wall."
    end
  end
end

Chase.run %w(mouse --name Jerry) # prints "Jerry runs away."
Chase.run %w(cat --name Tom)     # prints "Tom runs into a wall."
```

### Help

```crystal
class Call < Cli::Command
  class Help
    header "Receives an ancient message."
    footer "(C) 20XX mosop"
  end

  class Options
    arg "message", desc: "your message to call them", required: true
    bool "-w", not: "-W", desc: "wait for response", default: true
    help
  end
end

Call.run %w(--help)
# call [OPTIONS] MESSAGE
#
# Receives an ancient message.
#
# Arguments:
#   MESSAGE (required)  your message to call them
#
# Options:
#   -w          wait for response
#               (default: true)
#   -W          disable -w
#   -h, --help  show this help
#
# (C) 20XX mosop
```

### Versioning

```crystal
class Command < Cli::Supercommand
  version "1.0.0"

  class Options
    version
  end
end

Command.run %w(-v) # prints 1.0.0
```

### Bash Completion

```crystal
class TicketToRide < Cli::Command
  class Options
    string "--by", any_of: %w(train plane taxi), default: "train"
    arg "for", any_of: %w(kyoto kanazawa kamakura)
  end
end

puts TicketToRide.generate_bash_completion # prints a script
```

## Usage

```crystal
require "cli"
```

and see [Code Samples](#code_samples) and [Wiki](https://github.com/mosop/cli/wiki).

## Want to Do

- Application-Level Logger
- I18n

## Release Notes

See [Releases](https://github.com/mosop/cli/releases).
