# nastack
Stocks/options trading stack based on Kafka, Flink, and Kubernetes

This project is just getting started, but the goals are as follows:
 - trivially deploy a Kafka and Flink stack for personal use
 - automatically set up Kafka topics with real-time stock data
 - provide a library of Flink Connectors for connecting to stock trading APIs
 - enable interactive querying of live data with Flink SQL
 - enable submission of real trades via Flink SQL

For now, I'm focusing on TD Ameritrade's options APIs.

## quick-start
```shell
    $ make deploy
```

## Flink SQL Shell

You can attach to an interactive Flink SQL shell and run arbitrary
commands/queries (WIP -- no tables or sources are defined yet):

```shell
    $ make shell
```

Then type `help;` for options.
