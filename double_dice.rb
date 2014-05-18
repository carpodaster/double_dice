class DoubleDice

  class PasswordVector < Struct.new(:password)
    def to_a
      password.map{|char| ('A'..'Z').to_a.index(char) }.map(&:to_s)
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

  class Matrix < Struct.new(:cleartext, :password)

    def to_a
      matrix = [password]
      matrix << index_line

      line = []
      cleartext.each do |char|
        if line.size < password.size
          line << char
        else
          matrix << line
          line = [char]
        end
      end
      last_line = fill_last_line(line)
      matrix << last_line unless last_line.empty?
      matrix
    end

    private

    def fill_last_line(line)
      (password.size - line.size).times do
        line << '_'
      end
      line
    end

    def index_line
      PasswordVector.new(password).to_a
    end
  end

  attr_reader :cleartext, :password

  def initialize(cleartext, password)
    @cleartext = cleartext.upcase.strip.split(//).select{|c| /[A-Z]/ =~ c}
    @password  = password.upcase.strip.split(//)
  end

  def matrix
    Matrix.new(cleartext, password)
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
ddice = DoubleDice.new one_ring, 'foobar'

puts ddice.cleartext.inspect
puts
puts ddice.matrix.to_a.map(&:inspect)

shifter = DoubleDice::Shifter.new(ddice.matrix)
puts
puts shifter.to_a.map(&:inspect)
