require "srfax/version"

module Srfax
	class NumberScrubber

		def scrub(number)
			@number = (number.class == String ? number : number.to_s)
			remove_non_numerals
			remove_leading_one
			check_for_valid_length
			@number
		end

		private

		def remove_non_numerals
			@number.gsub!(/[^0-9]/,'')
		end

		def remove_leading_one
			if @number[0] == '1'
				@number = @number.slice(1..-1)
			elsif @number[0..1] == '+1'
				@number = @number.slice(2..-1)
			end
		end

		def check_for_valid_length
			if @number.length != 10
				raise "Invalid Fax Number #{@number}"
			end
		end
	end
end
