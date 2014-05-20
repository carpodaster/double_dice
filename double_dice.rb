$:.unshift '.'
require 'matrix'

module DoubleDice

  class PasswordVector < Struct.new(:password)
    def to_a
      password.map{|char| ('A'..'Z').to_a.index(char.upcase) }.map(&:to_i)
    end

    def to_hash
      to_a.inject({}) do |hash, pos|
        hash[to_a.index(pos)] = to_a.sort.index(pos)
        hash
      end
    end
  end

  class Shifter < Struct.new(:matrix)

    def to_a
      shifted_matrix = [matrix.password]
    end

    private

    def vector
      PasswordVector.new(matrix.password).to_a
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
ddice = DoubleDice::Input.new one_ring, 'foobar'

puts ddice.cleartext.inspect
puts
puts ddice.matrix

shifter = DoubleDice::Shifter.new(ddice.matrix)
puts
puts shifter.to_a.map(&:inspect)
