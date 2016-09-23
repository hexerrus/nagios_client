module NagiosClient

    def self.Services
      return Services.new(@hosts)
    end

  class Services

    def initialize(args)

      @hosts = [args] if args.is_a? NagiosClient::Host
      @hosts = args if args.is_a? Array
    end

    def all
      return prepare_services_array(@hosts)
    end

    def prepare_services_array(hosts)
      services = []
      hosts.each do |host|
        services += host.services.map{|s| s }
      end
      return services
    end

    def find(conditions={})
      services = []

      hostname_condition = conditions[:hostname]

      service_condition = conditions[:service]
      status_condition = conditions[:status]


      @hosts.each do |host|
        unless hostname_condition.nil?
          next if hostname_condition.is_a? String and host.hostname != hostname_condition
          next if hostname_condition.is_a? Regexp and !host.hostname.match(hostname_condition)
        end


        host.Services.all.each do |service|

          unless service_condition.nil?
            next if service_condition.is_a? String and service.service != service_condition
            next if service_condition.is_a? Regexp and !service.service.match(service_condition)
          end

          unless status_condition.nil?
            next if status_condition.is_a? Symbol and service.status != status_condition
            next if status_condition.is_a? String and service.status != status_condition.to_sym
          end

          services << service
        end
      end

      services
    end

  end

end
