module NagiosClient
  # base host class
  # @param [String] hostname
  # @param [String] status
  # @param [Boolean] downtime
  # @param [Boolean] ack
  class Host
    attr_accessor :hostname ,:status , :services, :downtime , :ack
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
