require "srfax/version"
require "httmultiparty"

module Srfax
  class API

    include HTTMultiParty

    base_uri 'https://www.srfax.com'
    headers 'User-Agent' => "hello_fax gem #{VERSION}"

    API_ENDPOINT = '/SRF_SecWebSvc.php'

    attr_accessor :guid

    def initialize(access_id, password, fax_number, email)
      @access_id = access_id
      @access_pwd = password
      @sender_fax_number = fax_number
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
    def send_fax(to, file, options={})
      @response = self.class.post(
        API_ENDPOINT,
        query: {
          action:           'Queue_Fax',
          access_id:        @access_id,
          access_pwd:       @access_pwd,
          sCallerID:        @sender_fax_number,
          sSenderEmail:     @sender_email,
          sFaxType:         options.fetch(:fax_type, 'SINGLE'),
          sToFaxNumber:     to,
          sResponseFormat:  'JSON',
          sRetries:         options.fetch(:retries, 3),
          sFileName_1:      file,
          sFileContent_1:   Base64.encode64(file.read)
        })
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
