require "srfax/version"
require "httmultiparty"

module Srfax
  class API

  	include ::HTTMultiParty

  	base_uri 'https://www.srfax.com'
  	headers 'User-Agent' => "hello_fax gem #{VERSION}"

  	API_ENDPOINT = '/SRF_SecWebSvc.php'

  	attr_accessor :guid

  	def initialize(username, password, guid)
  	  self.class.basic_auth username, password
  	  @guid = guid
  	end

  	# Queues a fax for sending
  	# Expected response:
  	# {
  	# 	"Status": either "Success" or "Failed",
  	# 	"Result": Queued Fax ID (FaxDetailsID) or Reason for failure
  	# }
  	def send_fax(to, file)
  		self.class.post(
  			API_ENDPOINT,
  			query: {
  				action: 					'Queue_Fax',
  				access_id: 				@access_id,
  				access_pwd: 			@access_pwd,
  				sCallerId: 				@sender_fax_number,
  				sSenderEmail: 		@sender_email,
  				sFaxType: 				'SINGLE', # TODO: make this "SINGLE" or "BROADCAST" optionally
  				sToFaxNumber: 		to,
  				sResponseFormat: 	'JSON',
  				sRetries: 				3,
  				sFileName_1: 			'preferral_file',
  				sFileContent_1: 	file
  			})
  	end
  end
end
