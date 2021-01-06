require 'spec_helper'

describe Srfax::NumberScrubber do
  describe 'with valid fax numbers of various input styles' do
    before :each do
      @good_numbers = [
        '(555) 555-5555',
        '555-555-5555',
        '5555555555',
        '(555)555-5555',
        '(555)-555-5555',
        '555.555.5555',
        '1 (555) 555-5555',
        '1-555-555-5555',
        '15555555555',
        '1(555)555-5555',
        '1(555)-555-5555',
        '1.555.555.5555',
        '+1 (555) 555-5555',
        '+1-555-555-5555',
        '+15555555555',
        '+1(555)555-5555',
        '+1(555)-555-5555',
        '+1.555.555.5555',
      ]
    end

    describe ':scrub method' do
      it 'should return a 11-digit number' do
        @good_numbers.each do |number|
          Srfax::NumberScrubber.new.scrub(number).length.should eql(11)
        end
      end
    end
  end

  describe 'with invalid fax numbers' do
    describe 'that are too short' do
      before :each do
        # Are there any area codes that start with '1'??
        @short_numbers = [
          '(555) 555-555',
          '555-555-555',
          '555555555',
          '(555)555-555',
          '(555)-555-555',
          '555.555.555',
          '1 (555) 555-555',
          '1-555-555-555',
          '1555555555',
          '1(555)555-555',
          '1(555)-555-555',
          '1.555.555.555',
          '+1 (555) 555-555',
          '+1-555-555-555',
          '+1555555555',
          '+1(555)555-555',
          '+1(555)-555-555',
          '+1.555.555.555',
        ]
      end

      describe ':scrub method' do
        it 'should raise error' do
          @short_numbers.each do |number|
            Srfax::NumberScrubber.new.scrub(number).length.should raise "error"
          end
        end
      end
    end

    describe 'that are too long' do
      before :each do
        @long_numbers = [
          '(555) 555-55556',
          '555-555-55556',
          '55555555556',
          '(555)555-55556',
          '(555)-555-55556',
          '555.555.55556',
          '1 (555) 555-55556',
          '1-555-555-55556',
          '155555555556',
          '1(555)555-55556',
          '1(555)-555-55556',
          '1.555.555.55556',
          '+1 (555) 555-55556',
          '+1-555-555-55556',
          '+155555555556',
          '+1(555)555-55556',
          '+1(555)-555-55556',
          '+1.555.555.55556',
        ]
      end
    end
  end
end
