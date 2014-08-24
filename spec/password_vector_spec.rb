require 'spec_helper'

describe DoubleDice::PasswordVector do

  describe '#size' do
    it 'returns the length of the password' do
      password = %w(A B C)
      subject  = described_class.new password

      subject.size.must_equal 3
    end
  end

  describe '#to_a' do
    it 'returns a list of alphabet indices' do
      password = %w(A B C)
      subject  = described_class.new password

      subject.to_a.must_equal [0, 1, 2]
    end

    it 'works with lowercase characters' do
      password = %w(a b c)
      subject  = described_class.new password

      subject.to_a.must_equal [0, 1, 2]
    end
  end

  describe '#transform' do
    it 'returns a sorted list' do
      password = %w(F U B A R)
      subject  = described_class.new password

      input  = %w(H E L L O)
      output = %w(L L H O E)

      subject.transform(input).must_equal output
    end

    it 'handles errors with input array not matching its length' do
      password = %w(F U B A R)
      subject  = described_class.new password

      begin
        subject.transform ('A'..'Z').to_a
        refute true, 'Exception must be raised'
      rescue => e
        e.must_be_instance_of ArgumentError
      end
    end
  end

  describe '#instructor' do
    context 'with password input already sorted' do
      it 'maps character position to its supposed sorted position' do
        password = %w(A B C)
        subject  = described_class.new password

        expected = [ [0, 0], [1, 1], [2, 2] ]
        subject.instructor.must_equal expected
      end
    end

    context 'with password input unsorted' do
      it 'maps character position to its supposed sorted position' do
        password = %w(F U B A R)
        subject  = described_class.new password

        expected = [ [0, 2], [1, 4], [2, 1], [3, 0], [4, 3] ]
        subject.instructor.must_equal expected
      end

      it 'handles characters that occur twice' do
        password = %w(F O O B A R)
        subject  = described_class.new password

        expected = [ [0, 2], [1, 3], [2, 4], [3, 1], [4, 0], [5, 5 ] ]
        subject.instructor.must_equal expected
      end

      it 'handles characters that occur more than twice' do
        password = %w(N O T E B O O K)
        subject  = described_class.new password

        expected = [ [0, 3], [1, 4], [2, 7], [3, 1], [4, 0], [5, 5], [6, 6], [7, 2] ]
        subject.instructor.must_equal expected
      end
    end
  end

  def described_class
    DoubleDice::PasswordVector
  end
end
