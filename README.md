# Srfax

Gem to send faxes using the SRFax API

## Installation

Add this line to your application's Gemfile:

    gem 'srfax'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install srfax

## Usage

faxer = Srfax.new(access_id, password, sending_fax_number, sender_email)
faxer.send_fax(recipient_fax_number, file_object)

### End Point

POSTS are sent to the following URL: `https://www.srfax.com/SRF_SecWebSvc.php`

TODO: Write usage instructions here

## Contributing

1. Fork it ( https://github.com/preferral/srfax/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
