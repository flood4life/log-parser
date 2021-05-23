# Webserver log parser

## Requirements

- Ruby 3.0.1

## Running

### Install gems

```sh
bundle install
```

### Run the program

```sh
./parser.rb FILE_PATH
```

e.g.

```sh
./parser.rb data/webserver.log
```

### Run tests

```sh
rake
```

### Run rubocop

```sh
rake rubocop
```

## Design considerations

Server log files can be quite large (tens of GBs), so the program cannot afford the luxury of loading the entire data set in memory. Hence, the components are designed in a way to retain the bare minimum amount of data to calculate the stats correctly.

The file is read line by line, `LineParser` transforms the string into a `Line`, which is fed into `VisitsCounter`, that keeps track of the total visits for each page and the unique IPs associated with each page. `StatsSorter` provides convenience methods to sort the stats based on the business requirements, `StdoutPresenter` transforms the stats into a string suitable for printing to STDOUT, and the `ProcessFile` command orchestrates the entire operation. Then it's up to the `parser.rb` script to wrap the command, provide the CLI and print the result.

The responsibilities of each component are strictly limited and are easily tested in isolation (see the unit tests).
