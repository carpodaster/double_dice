require 'double_dice/matrix'
require 'double_dice/password_vector'
require 'double_dice/shifter'

module DoubleDice

  def encrypt(message: message, password1: password1, password2: password2)
    matrix1 = DoubleDice::Input.new(message, password1).matrix.sort
    shifter = Shifter.new matrix1

    matrix2 = DoubleDice::Input.new(shifter.to_s, password2).matrix.sort
    Shifter.new(matrix2).to_s
  end
  module_function :encrypt

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

