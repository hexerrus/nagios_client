require "nagios_client/version"
require "nagios_client/hosts"
require "nagios_client/services"
require "nagios_client/host"
require "nagios_client/service"


module NagiosClient


  attr_accessor :host, :username, :password, :hosts
  def self.new(args)
    @uri = args[:uri]
    @username = args[:username]
    @password = args[:password]
    @hosts = []
    self
  end
  def self.update
    page = Nokogiri::HTML(
      open(
         "#{@uri}status.cgi?host=all&limit=0",
         :http_basic_authentication => [@username, @password]
       ),
    )
    trs = page.css('.status > tr') 
    trs.shift # remove first element

    trs.each do |tr|
      next if tr.text == ""
      host_cell = tr.css('td')[0]

      unless host_cell.text.delete!("\n").nil?
        host_status = (host_cell.attribute('class').to_s == 'statusHOSTDOWN') ? :down : :up
        host_downtime = host_cell.css('img').find{|img| /downtime/ =~ img.attribute('src')}.nil? ? false : true
        host_ack = host_cell.css('img').find{|img| /images\/ack/ =~ img.attribute('src')}.nil? ? false : true

        @hosts <<  Host.new(
          :hostname => host_cell.text.delete!("\n"),
          :status => host_status,
          :downtime => host_downtime,
          :ack => host_ack,
        )
      end

      host = @hosts.last
      line = tr.xpath("./td")
      service_name = line[1].text.delete!("\n")
      service_status = line[2].text
      last_check = line[3].text.to_s
      duration = line[4].text.to_s
      information = line[6].text.to_s.chop

      service_downtime = line[1].css('img').find{|img| /downtime/ =~ img.attribute('src')}.nil? ? false : true
      service_ack = line[1].css('img').find{|img| /images\/ack/ =~ img.attribute('src')}.nil? ? false : true

      service = Service.new(
        :service => service_name,
        :status => service_status,
        :last_check => last_check,
        :duration => duration,
        :information => information,
        :downtime => service_downtime,
        :ack => service_ack,
        :host => host
      )
      host.services << service

    end

  end

  def self.all
    @hosts
  end

end
