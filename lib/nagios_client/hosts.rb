module NagiosClient

    def self.Hosts
      return Hosts.new(@hosts)
    end

  class Hosts

    def initialize(hosts)
      @hosts = hosts
    end

    def all
      return @hosts
    end

    def find(conditions={})

      result = []

      hostname_condition = conditions[:hostname]
      status_condition = conditions[:status]

      @hosts.each do |host|
        unless hostname_condition.nil?
          next if hostname_condition.is_a? String and host.hostname != hostname_condition
          next if hostname_condition.is_a? Regexp and !host.hostname.match(hostname_condition)
        end

        unless status_condition.nil?
          next if status_condition.is_a? Symbol and host.status != status_condition
          next if status_condition.is_a? String and host.status != status_condition.to_sym
        end

        result << host
      end
      result
    end

  end

end
