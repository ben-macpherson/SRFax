[![Stories in Ready](https://badge.waffle.io/preferral/srfax.png?label=ready&title=Ready)](https://waffle.io/preferral/srfax)
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
    faxer = Srfax::API.new(access_id, password, sender_email, sender_number)
    faxer.send_fax(recipient_fax_number_or_array_of_numbers, options_hash, array_of_file_objects)

## Tips
File objects are expected in the following format:
    File.open('/Users/Geekoncoffee/Desktop/file.pdf')

Example from Prawn:
    tmp_file = Tempfile.new(Digest::MD5.hexdigest(rand(12).to_s))
    pdf = Prawn::Document.new
    pdf.text "Hello World"
    pdf.render_file(tmp_file.path)

### End Point

POSTS are sent to the following URL: `https://www.srfax.com/SRF_SecWebSvc.php`

TODO:
 * Support Cover Pages
 * Support HTTP callback

## Contributing

1. Fork it ( https://github.com/preferral/srfax/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
