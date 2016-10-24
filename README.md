# Consul DNS Zero TTL Experiment

Consul recommends running with 0 TTL.  However, not all languages and systems behave the same under 0 TTL.

This is a testbed for characterizing that behavior.

## Testbed setup Instructions

Make sure you have the latest vagrant installed: https://www.vagrantup.com/downloads.html

```bash
# Start and ssh in
vagrant up
vagrant ssh

## Window 1
# Start consul, binding default port for dns
sudo /usr/local/bin/consul agent -dev -config-dir=/etc/consul.d/ -client 0.0.0.0 -dns-port 53 -recursor 8.8.8.8

## Window 2
# Start a simple http server to respond to HTTP requests
python -m SimpleHTTPServer 8080

## Window 3
# Check that both normal and upstream responses are working
dig @127.0.0.1 web.service.consul
dig @127.0.0.1 google.com

# Check that we can get to our fake app server
http://web.service.consul:8080

```

Also, you should be able to visit consul's web UI by visiting http://localhost:8500/.  At http://localhost:8500/ui/#/dc1/services you should see both the `web` and `consul` services listed.

## Experiments

Run the following to test all systems.

```bash
$ bash test_lookups.sh
Testing python
100
Testing curl
100
Testing go; pure go resolver
200
Testing go; cgo resolver
100
Testing node
100
Testing java
1
Testing java; explicit ttl 0
100
```

Notes:

* go's default pure go resolver double sends DNS requests
* java [will cache DNS lookups forever by default](http://stackoverflow.com/questions/1256556/any-way-to-make-java-honor-the-dns-caching-timeout-ttl), but you can override this

## Docs

* Consul's DNS interface
    * https://www.consul.io/docs/agent/dns.html
    * https://www.consul.io/docs/agent/options.html#dns_config

