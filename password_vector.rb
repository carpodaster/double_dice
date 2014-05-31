module DoubleDice
  class PasswordVector < Struct.new(:password)
    def size
      to_a.size
    end

    def to_a
      password.map{|char| ('A'..'Z').to_a.index(char.to_s.upcase) }.map(&:to_i)
    end

    def instructor
      sorted, target_map = to_a.sort, Array.new(size)
      to_a.each_with_index do |char_pos, index|
        origin_pos = to_a.index(char_pos)
        target_pos = sorted.index(char_pos)
        if target_map[index-1] == [origin_pos, target_pos]
          origin_pos += 1
          target_pos += 1
        end
        target_map[index] = [origin_pos, target_pos]
      end
      target_map
    end

    def transform(array)
      if array.size != size
        message = "Illegal input length #{array.size} for #{size}"
        raise ArgumentError.new(message)
      end
      transformed = Array.new(size)
      instructor.each { |from, to| transformed[to] = array[from] }
      transformed
    end
  end
end
