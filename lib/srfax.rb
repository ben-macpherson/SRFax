require "srfax/version"
require "srfax/number_scrubber"
require "httmultiparty"

module Srfax
  class API

    include HTTMultiParty

    base_uri 'https://www.srfax.com'
    headers 'User-Agent' => "srfax gem #{VERSION}"

    API_ENDPOINT = '/SRF_SecWebSvc.php'

    attr_accessor :guid

    def initialize(access_id, password, email, sender_number = '6159881522')
      @scrubber = Srfax::NumberScrubber.new
      @sender_fax_number = @scrubber.scrub(sender_number)
      @access_id = access_id
      @access_pwd = password
      @sender_email = email
    end

    # Queues a fax for sending
    # params:
    #   to => 10 digit recipient fax number
    #   file => File.open('filename.pdf')
    #   options => Optional hash - fax_type (SINGLE (default)/BROADCAST), retries (default: 3)
    #
    # Expected response:
    # {
    #   "Status": either "Success" or "Failed",
    #   "Result": Queued Fax ID (FaxDetailsID) or Reason for failure
    # }
    def send_fax(to, options, *files)
      options ||= {}
      print files
      print ""
      if to.is_a? Array
        if to.length > 50
          raise "Too Many Recipient Numbers"
        end
        to = to.map {|num| @scrubber.scrub(num) }.join("|")
        options[:fax_type] = 'BROADCAST'
      else
        to = @scrubber.scrub(to)
      end

      puts to

      query = {
          action:           'Queue_Fax',
          access_id:        @access_id,
          access_pwd:       @access_pwd,
          sCallerID:        @sender_fax_number,
          sSenderEmail:     @sender_email,
          sFaxType:         options.fetch(:fax_type, 'SINGLE'),
          sToFaxNumber:     '16155159891',#to,
          sResponseFormat:  options.fetch(:response_format, 'JSON'),
          sRetries:         options.fetch(:retries, 3)
      }

      [files].flatten.each_with_index do |file, index|
        query["sFileName_#{index}"]    = "yo_yo_yo.pdf"
        query["sFileContent_#{index}"] = Base64.encode64(file.read)
      end

      @response = self.class.post(API_ENDPOINT, query: query)
      @response
    end

    def get_usage
      @response = self.class.post(
        API_ENDPOINT,
        query: {
          action:     'Get_Usage',
          access_id:  @access_id,
          access_pwd: @access_pwd,
          sResponseFormat: 'JSON',
          sPeriod: 'ALL'
        })
      @response
    end

    def get_fax_status(fax_id)
      @response = self.class.post(
        API_ENDPOINT,
        query: {
          action: 'Get_FaxStatus',
          access_id: @access_id,
          access_pwd: @access_pwd,
          sFaxDetailsID: fax_id,
          sResponseFormat: 'JSON'
        })
      @response
    end

    def response
      @response
    end
  end
end
