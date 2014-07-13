require "srfax/version"

module Srfax
	class NumberScrubber

		def scrub(number, check_for_length=true)
			@number = (number.class == String ? number : number.to_s)
			remove_non_numerals
			check_for_valid_length if check_for_length
			@number
		end

		private

		def remove_non_numerals
			@number.gsub!(/[^0-9]/,'')
		end

		def check_for_valid_length
			if @number.length == 10
				@number = "1#{@number}"
			end

			if @number.length < 11
				raise "Invalid Fax Number #{@number}"
			end
		end
	end
end
