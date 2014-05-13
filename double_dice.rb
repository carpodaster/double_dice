class DoubleDice

  attr_reader :cleartext, :password

  def initialize(cleartext, password)
    @cleartext = cleartext.upcase.strip.split(//).select{|c| /[A-Z]/ =~ c}
    @password  = password.upcase.strip.split(//)
  end

  def matrix
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
    matrix << line if line.any? && line.size < password.size
    matrix
  end

  def index_line
    password.map{|char| ('A'..'Z').to_a.index(char) }.map(&:to_s)
  end

end


slipsum = <<EOSLIPSUM
The path of the righteous man is beset on all sides by the iniquities of the selfish and the tyranny of evil men. Blessed is he who, in the name of charity and good will, shepherds the weak through the valley of darkness, for he is truly his brother's keeper and the finder of lost children. And I will strike down upon thee with great vengeance and furious anger those who would attempt to poison and destroy My brothers. And you will know My name is the Lord when I lay My vengeance upon thee.
EOSLIPSUM

# print 'Please enter the cleartext: '
# text = gets
#
# print 'Please enter a password: '
# pass = gets

# ddice = DoubleDice.new text, pass
ddice = DoubleDice.new slipsum, 'foobar'

puts ddice.cleartext.inspect
puts
puts ddice.matrix.map(&:inspect)
