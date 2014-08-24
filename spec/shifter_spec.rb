require 'spec_helper'

describe DoubleDice::Shifter do

  describe '#to_s' do
    it 'reads the matrix column wise' do
      matrix = [
        ["O", "L", "S", "H", "A", "D", "A", "L"],
        ["I", "R", "E", "H", "I", "S", "T", "E"],
        ["N", "A", "R", "I", "N", "G", "E", "L"],
        ["P", "S", "L", "B", "E", "I", "E", "I"],
        ["U", "T", "A", "T", "E", "M", "D", "X"],
        ["F", "R", "R", "S", "V", "A", "H", "E"],
        ["Z", "U", "G", "E", "N", "E", "I", "Z"],
        ["_", "_", "_", "E", "N", "_", "_", "_"]
      ]
      expected = 'OINPU FZLRA STRUS ERLAR GHHIB TSEEA INEEV NNDSG IMAEA TEEDH ILELI XEZ'.gsub(' ', '')

      DoubleDice::Shifter.new(matrix).to_s.must_equal expected
    end
  end

end
