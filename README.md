# NagiosClient

Simple ruby gem for getting data from Nagios through web interface using nokogiri

[Documentation](https://hexerrus.github.io/nagios_client/doc/)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nagios_client', :git => 'https://github.com/hexerrus/nagios_client.git'
```

And then execute:

     `bundle`

## Usage

### Get all data

```ruby
require 'nagios_client'


client = NagiosClient.new(
      :uri => "http://nagioscore.demos.nagios.com/nagios/cgi-bin/",
      :username => 'nagiosadmin',
      :password => 'nagiosadmin')
client.update # download and parse all data from nagios
puts client.Hosts.all # return all data
```
### find hosts
```ruby
hosts = client.Hosts.find(:hostname => 'mailserver', :status => :up) # will return Array of hosts
# also you can use :downtime => true || false
# and :ack => true || false
```
or with Regexp

```ruby
hosts client.Hosts.find(:hostname => /^mailserver$/, :status => :up)
```

### find services
```ruby
services = client.Services.find(:hostname => 'mailserver', :service => /postfix_queue/, :status => :CRITICAL)
# also you can use :downtime => true || false
# and :ack => true || false
```

### get services by host
```ruby
client.Hosts.find(:hostname => 'mailserver').first.Services.all
```

### hostname by service
```ruby
client.Services.find(:service => /postfix_queue/, :status => :CRITICAL).first.Host.hostname
```

### array of hosts
```ruby
client.Services.find(:service => /postfix_queue/, :status => :CRITICAL).map{|service| service.Host.hostname }
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hexerrus/nagios_client.
