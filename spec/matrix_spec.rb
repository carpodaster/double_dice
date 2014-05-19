require 'spec_helper'

describe DoubleDice::Matrix do
  describe 'its constructor' do
    it 'sets cleartext and password without sanitizing them' do
      cleartext, password = 'foo', 'bar'
      subject = DoubleDice::Matrix.new cleartext, password

      subject.cleartext.must_equal cleartext
      subject.password.must_equal password
    end
  end

  describe '#to_a' do
    it 'arranges the cleartext in lines' do
      cleartext = %w(H E L L O W O R L D)
      password  = %w(F U B A R)
      subject   = DoubleDice::Matrix.new cleartext, password

      expected  = [
        password,
        password_index_line(password), # TODO remove me
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
        password,
        password_index_line(password), # TODO remove me
        %w(H E L L O W),
        %w(O R L D _ _)
      ]
      subject.to_a.must_equal expected
    end

    def password_index_line(password)
      DoubleDice::PasswordVector.new(password).to_a
    end
  end

end
