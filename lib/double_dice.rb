require 'double_dice/matrix'
require 'double_dice/password_vector'
require 'double_dice/shifter'
require 'double_dice/input'

module DoubleDice

  def encrypt(message: message, password1: password1, password2: password2)
    matrix1 = DoubleDice::Input.new(cleartext: message, password: password1).matrix
    shifter = Shifter.new matrix1.sort

    matrix2 = DoubleDice::Input.new(cleartext: shifter, password: password2).matrix
    Shifter.new(matrix2.sort).to_s
  end

  module_function :encrypt

end
