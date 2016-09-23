module NagiosClient
  class Service
    attr_accessor :service ,:status, :last_check, :duration, :information, :host, :downtime , :ack

    def initialize(args)
      @service = args[:service]
      @status = args[:status].to_sym
      @last_check = args[:last_check]
      @duration = args[:duration]
      @information = args[:information]
      @host = args[:host]
      @downtime = args[:downtime]
      @ack = args[:ack]
    end

    def to_s
      "service: #{@service} , status: #{@status} , last_check: #{@last_check}, duration: #{@duration} ,  information: #{@information}"
    end

    def to_hash
      {
        :service => @service,
        :status => @status,
        :last_check => @last_check,
        :duration => @duration,
        :information => @information,
        :downtime => @downtime,
        :ack => @ack,
      }
    end
  end
end
