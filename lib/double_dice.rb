require 'double_dice/matrix'
require 'double_dice/password_vector'

module DoubleDice

  def encrypt(message: message, password1: password1, password2: password2)
    matrix1 = DoubleDice::Input.new(message, password1).matrix.sort
    shifter = Shifter.new matrix1

    matrix2 = DoubleDice::Input.new(shifter.to_s, password2).matrix.sort
    Shifter.new(matrix2).to_s
  end
  module_function :encrypt

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

