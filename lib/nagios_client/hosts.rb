module NagiosClient
    # @return [Hosts] element of Hosts class
    class Client
      def Hosts
        return Hosts.new(@hosts)
      end
    end
  # Hosts class for convenient access to data and search
  class Hosts
    # constructor
    # @param [Array] hosts - array of Host class elements
    def initialize(hosts)
      @hosts = hosts
    end
    #return all hosts
    def all
      return @hosts
    end

    # find hosts, help to fine hosts by hostname, status , downtime , ack.
    # seacrh by hostname possible by String or Regexp
    # @param [String] :hostname example: find(:hostname => 'mailserver.com')
    # @param [Regexp] :hostname example: find(:hostname => /^databaserole/)
    # @param [Symbol] :status  :up or :down
    # @param [Boolean] :downtime true - downtime enabled
    # @param [Boolean] :ack true - acknowledgement enabled
    # @return [Array] Array with finded hosts
    def find(conditions={})

      result = []

      hostname_condition = conditions[:hostname]
      status_condition = conditions[:status]
      downtime_condition = conditions[:downtime]
      ack_condition = conditions[:ack]

      @hosts.each do |host|
        unless hostname_condition.nil?
          next if hostname_condition.is_a? String and host.hostname != hostname_condition
          next if hostname_condition.is_a? Regexp and !host.hostname.match(hostname_condition)
        end

        unless status_condition.nil?
          next if status_condition.is_a? Symbol and host.status != status_condition
          next if status_condition.is_a? String and host.status != status_condition.to_sym
        end
        next if !downtime_condition.nil? and host.downtime != downtime_condition
        next if !ack_condition.nil? and host.ack != ack_condition

        result << host
      end
      result
    end

  end

end
