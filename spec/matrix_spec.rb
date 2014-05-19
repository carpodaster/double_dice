require 'spec_helper'

describe DoubleDice::Matrix do
  describe 'its constructor' do
    it 'sets cleartext and password without sanitizing them' do
      cleartext, password = 'foo'.split(//), 'bar'.split(//)
      subject = DoubleDice::Matrix.new cleartext, password

      subject.cleartext.must_equal cleartext
      subject.password.must_equal password
    end

    it 'requires cleartext to be an array' do
      cleartext, password = 'foo', 'bar'.split(//)
      instantiate_matrix_and_rescue cleartext, password
    end

    it 'requires password to be an array' do
      cleartext, password = 'foo'.split(//), 'bar'
      instantiate_matrix_and_rescue cleartext, password
    end

    # Shared example for constructor parameter check
    def instantiate_matrix_and_rescue(*args)
      begin
        DoubleDice::Matrix.new(*args)
        refute true, 'Exception must be raised'
      rescue => e
        e.must_be_instance_of ArgumentError
      end
    end
  end

  describe '#to_a' do
    it 'arranges the cleartext in lines' do
      cleartext = %w(H E L L O W O R L D)
      password  = %w(F U B A R)
      subject   = DoubleDice::Matrix.new cleartext, password

      expected  = [
        %w(H E L L O),
        %w(W O R L D)
      ]
      subject.to_a.must_equal expected
    end

    it 'fills last line with underscores' do
      cleartext = %w(H E L L O W O R L D)
      password  = %w(F O O B A R)
      subject   = DoubleDice::Matrix.new cleartext, password

      expected  = [
        %w(H E L L O W),
        %w(O R L D _ _)
      ]
      subject.to_a.must_equal expected
    end

  end

  describe '#to_s' do
    it 'returns the arranged cleartext with password and index line header rows' do
      cleartext = %w(H E L L O W O R L D)
      password  = %w(F O O B A R)
      subject   = DoubleDice::Matrix.new cleartext, password

      expected  = [
        password,
        password_index_line(password),
        %w(H E L L O W),
        %w(O R L D _ _)
      ].map(&:inspect).join("\n")
      subject.to_s.must_equal expected
    end

    def password_index_line(password)
      DoubleDice::PasswordVector.new(password).to_a
    end
  end

end
