require 'double_dice'
require 'minitest/autorun'

def context(*args, &block)
  describe(*args, &block)
end
