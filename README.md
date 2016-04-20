# spring-logstash-filters

A set of logstash filters to parse Spring.IO log messages sent via a Loggregator syslog drain.

### Getting started

* Only tested on Mac

#### Grab the repo

```
git clone --recursive https://github.com/mrdavidlaing/spring-logstash-filters.git
cd spring-logstash-filters
bin/install-dependencies
```

You know its worked if you see:

```
Downloading and installing logstash-2.2.0 to vendor/logstash-2.2.0...
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  123M  100  123M    0     0   452k      0  0:04:39  0:04:39 --:--:--  594k
Installing logstash-devutils, logstash-codec-plain, logstash-filter-mutate, jdbc-sqlite3, flores, rspec, stud, pry, rspec-wait, logstash-codec-json, ftw, logstash-output-elasticsearch, gmetric, gelf, timecop, jdbc-derby, docker-api, simplecov, coveralls, vcr, webmock, json, longshoreman, logstash-input-generator, rumbster, logstash-filter-kv, logstash-filter-ruby, sinatra, webrick, poseidon, logstash-output-lumberjack, logstash-codec-line, logstash-filter-grok
Installation successful
Done.  Using logstash logstash 2.2.0 from /Users/mrdavidlaing/code/mrdavidlaing/spring-logstash-filters/vendor/logstash-2.2.0
```

#### Build and test the filters

```
bin/test
```

You know its worked if you something like: 

```
mkdir -p target
rm -rf target/*
===> Building ...
===> Artifacts:
target
target/logstash-filters-default.conf
target/logstash-filters-spring.conf
target/parsing_rules.html
===> Testing ...
 LANGUAGE="C.UTF-8" LC_ALL="C.UTF-8" LANG="C.UTF-8" vendor/logstash/bin/rspec $(find test -name '*spec.rb') --colour --format progress --format html --out target/parsing_rules.html
Using Accessor#strict_set for specs
Run options: exclude {:redis=>true, :socket=>true, :performance=>true, :couchdb=>true, :elasticsearch=>true, :elasticsearch_secure=>true, :export_cypher=>true, :integration=>true, :windows=>true}
..............

Finished in 0.475 seconds (files took 1.41 seconds to load)
14 examples, 0 failures

Randomized with seed 52304
```

#### Add the [generated config](target/logstash-filters-spring.conf) to the `filter {}` section of your Logstash config.

 

