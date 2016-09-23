module NagiosClient
  class Host
    attr_accessor :hostname ,:status , :services
    def initialize(args)
      @hostname = args[:hostname]
      @status = args[:status]
      @services = []
      @downtime = args[:downtime]
      @ack = args[:ack]

    end

    def hostname
      @hostname
    end

    def status
      @status
    end

    def Services
      Services.new(self)
    end

    def to_s
      "hostname: #{@hostname} , status: #{@status} , services: #{@services.inspect}"
    end
  end
end
