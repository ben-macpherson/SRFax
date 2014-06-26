require 'spec_helper'

describe Srfax do
  describe 'when initialized with valid credentials' do
  	before :each do
  		@client = Srfax::API.new('27752','WorkMain12')
  	end

  	it 'should send a fax' do
			stub_request(:post, 'https://www.srfax.com/SRF_SecWebSvc.php').with { |request| request.body == "action=Queue_Fax&access_id=27752&access_pwd=WorkMain12&sCallerID=6159881522&sSenderEmail=jon%40workmein.com&sFaxType=SINGLE&sToFaxNumber=16155159891&sResponseFormat=JSON&sRetries=3&sFileName_1=test_fax_doc.pdf&sFileContent_1=file_content" }
  		g = File.open("test_fax_doc.pdf")
  		@client.send_fax('6155159891',g)
  	end
  end
end
