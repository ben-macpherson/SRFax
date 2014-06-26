require "srfax/version"
require "httmultiparty"

module Srfax
  class API

    include HTTMultiParty

    base_uri 'https://www.srfax.com'
    headers 'User-Agent' => "hello_fax gem #{VERSION}"

    API_ENDPOINT = '/SRF_SecWebSvc.php'

    attr_accessor :guid

    def initialize(access_id, password)
      @access_id = access_id
      @access_pwd = password
      @sender_fax_number = '6159881522'
      @sender_email = 'jon@workmein.com'
    end

    # Queues a fax for sending
    # params:
    #   to => 10 digit recipient fax number
    #   file => File.open('filename.pdf')
    #
    # Expected response:
    # {
    #   "Status": either "Success" or "Failed",
    #   "Result": Queued Fax ID (FaxDetailsID) or Reason for failure
    # }
    def send_fax(to, file)
      @response = self.class.post(
        API_ENDPOINT,
        query: {
          action:           'Queue_Fax',
          access_id:        @access_id,
          access_pwd:       @access_pwd,
          sCallerID:        @sender_fax_number,
          sSenderEmail:     @sender_email,
          sFaxType:         'SINGLE', # TODO: make this "SINGLE" or "BROADCAST" optionally
          sToFaxNumber:     '16155159891',#to,
          sResponseFormat:  'JSON',
          sRetries:         3,
          sFileName_1:      'test_fax_doc.pdf',
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
