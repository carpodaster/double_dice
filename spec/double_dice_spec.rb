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

