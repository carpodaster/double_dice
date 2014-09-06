module DoubleDice
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
end
