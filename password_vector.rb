module DoubleDice
  class PasswordVector < Struct.new(:password)
    def size
      to_a.size
    end

    def to_a
      password.map{|char| ('A'..'Z').to_a.index(char.to_s.upcase) }.map(&:to_i)
    end

    def instructor
      target_map = Array.new(size)
      to_a.each_with_index do |char_pos, index|
        origin_pos = origin_position_respecting_duplicates(target_map, char_pos)
        target_pos = target_position_respecting_duplicates(target_map, char_pos)
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

    private

    def origin_position_respecting_duplicates(target_map, char_pos)
      target_map_size = target_map.compact.size
      last_pos = to_a[0..target_map_size].rindex(char_pos)
      last_pos + to_a[last_pos..-1].index(char_pos)
    end

    def target_position_respecting_duplicates(target_map, char_pos)
      target_map_size = target_map.compact.size
      occurences = to_a[0..target_map_size].select{|pos| pos == char_pos}.count
      to_a.sort.index(char_pos) + occurences - 1 #if occurences > 1
    end

  end
end
