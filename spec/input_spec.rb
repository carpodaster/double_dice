require 'spec_helper'

describe DoubleDice::Input do
  describe 'its constructor' do
    context 'setting the cleartext' do
      it 'sets the cleartext as character array' do
        cleartext = 'FOOBAR'
        subject = described_class.new cleartext, ''

        subject.cleartext.must_equal %w(F O O B A R)
      end

      it 'upcases the characters' do
        cleartext = 'foobar'
        subject = described_class.new cleartext, ''

        subject.cleartext.must_equal %w(F O O B A R)
      end

      it 'removes non-word characters' do
        cleartext = "f00b_ r \n "
        subject = described_class.new cleartext, ''

        subject.cleartext.must_equal %w(F B R)
      end
    end

    context 'setting the password' do
      it 'sets the password as character array' do
        password = 'FOOBAZ'
        subject = described_class.new '', password

        subject.password.must_equal %w(F O O B A Z)
      end

      it 'upcases the characters' do
        password = 'foobar'
        subject = described_class.new '', password

        subject.password.must_equal %w(F O O B A R)
      end

      it 'removes whitespaces' do
        password = "f00b_ r \n "
        subject = described_class.new '', password

        subject.password.must_equal %w(F 0 0 B _ R)
      end
    end
  end

  def described_class
    DoubleDice::Input
  end
end
