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

  describe '#to_hash' do
    context 'with password input already sorted' do
      it 'maps character position to its supposed sorted position' do
        password = %w(A B C)
        subject  = described_class.new password

        expected = { 0 => 0, 1 => 1, 2 => 2 }
        subject.to_hash.must_equal expected
      end
    end

    context 'with password input unsorted' do
      it 'maps character position to its supposed sorted position' do
        password = %w(F U B A R)
        subject  = described_class.new password

        expected = { 0 => 2, 1 => 4, 2 => 1, 3 => 0, 4 => 3 }
        subject.to_hash.must_equal expected
      end

      it 'handles characters that occur twice' do
        password = %w(F O O B A R)
        subject  = described_class.new password

        skip 'Index of O will be overwritten in resulting hash, resulting hash will miss one element'
        subject.to_hash.must_equal expected
      end
    end
  end

  def described_class
    DoubleDice::PasswordVector
  end
end
