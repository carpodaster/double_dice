require 'spec_helper'

describe DoubleDice do
  it 'encrypts the lint text' do
    message = 'HALLODASHIERISTEINLANGERBEISPIELTEXTUMDASVERFAHRENZUZEIGEN'
    expected = [
      %w(N O I U P F),
      %w(R Z L S A T),
      %w(G A R H H I),
      %w(S B T E E A),
      %w(E I N V E N),
      %w(S N D I G M),
      %w(A A E E T E),
      %w(I D H E L L),
      %w(E I X _ Z _)
    ]

    expected = 'NRSGS ESAIE OZRAB INADI ILURT NDEHX USRHE VIEEP AEHEE GTLZF TLIAN MEL'.tr(' ', '')

    DoubleDice.encrypt(
      message: message,
      password1: 'NOTEBOOK',
      password2: 'DECKEL'
    ).must_equal expected
  end
end

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
