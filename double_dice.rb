$:.unshift '.'
require 'matrix'
require 'password_vector'

module DoubleDice

  class Shifter < Struct.new(:matrix)

    def to_s
      shifted = ''
      column = 0
      while column < vector_length do
        0.upto(matrix.size - 1) do |line|
          shifted << matrix[line][column]
        end
        column += 1
      end
      shifted.tr(' _', '')
    end

    private

    def vector_length
      @vector_length ||= matrix.first.length
    end

  end

  class Input # TODO rename me

    attr_reader :cleartext, :password

    def initialize(cleartext, password)
      @cleartext = cleartext.upcase.strip.split(//).select{|c| /[A-Z]/ =~ c}
      @password  = password.upcase.strip.gsub(/\s/, '').split(//)
    end

    def matrix
      DoubleDice::Matrix.new(cleartext, password)
    end
  end
end

slipsum = <<EOSLIPSUM
The path of the righteous man is beset on all sides by the iniquities of the selfish and the tyranny of evil men. Blessed is he who, in the name of charity and good will, shepherds the weak through the valley of darkness, for he is truly his brother's keeper and the finder of lost children. And I will strike down upon thee with great vengeance and furious anger those who would attempt to poison and destroy My brothers. And you will know My name is the Lord when I lay My vengeance upon thee.
EOSLIPSUM

one_ring = <<EOMIDDLEEARTH
One Ring to rule them all,
One Ring to find them,
One ring to bring them all,
And in the darkness bind them
EOMIDDLEEARTH

# print 'Please enter the cleartext: '
# text = gets
#
# print 'Please enter a password: '
# pass = gets

# ddice = DoubleDice.new text, pass
# ddice = DoubleDice.new slipsum, 'foobar'
ddice = DoubleDice::Input.new one_ring, 'foubar'
lint = 'HALLODASHIERISTEINLANGERBEISPIELTEXTUMDASVERFAHRENZUZEIGEN'
ddice = DoubleDice::Input.new lint, 'NOTEBOOK'

puts ddice.cleartext.inspect
puts
puts ddice.matrix

shifted1 = ddice.matrix.sort
puts
puts shifted1.to_a.map(&:inspect)
