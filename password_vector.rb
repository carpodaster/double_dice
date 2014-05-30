module DoubleDice
  class PasswordVector < Struct.new(:password)
    def size
      to_a.size
    end

    def to_a
      password.map{|char| ('A'..'Z').to_a.index(char.to_s.upcase) }.map(&:to_i)
    end

    def to_hash
      to_a.inject({}) do |hash, pos|
        hash[to_a.index(pos)] = to_a.sort.index(pos)
        hash
      end
    end

    def transform(array)
      if array.size != size
        message = "Illegal input length #{array.size} for #{size}"
        raise ArgumentError.new(message)
      end
      transformed = Array.new(size)
      to_hash.each { |from, to| transformed[to] = array[from] }
      transformed
    end
  end
end
