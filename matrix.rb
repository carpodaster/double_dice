module DoubleDice
  class Matrix

    attr_reader :cleartext, :password

    def initialize(cleartext, password)
      unless [cleartext, password].all? { |arg| arg.kind_of? Array }
        raise ArgumentError.new('Provided argument is not an Array')
      end
      @cleartext, @password = cleartext, password
    end

    # Reorders the columns based on the set password
    def sort
      to_a.map { |line| vector.transform(line) }
    end

    def to_a
      matrix, line = [], []
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

    def to_s
      matrix = to_a
      matrix.unshift index_line
      matrix.unshift Array(password)
      matrix.map(&:inspect).join("\n")
    end

    private

    def fill_last_line(line)
      (password.size - line.size).times do
        line << '_'
      end
      line
    end

    def vector
      @vector ||= PasswordVector.new(password)
    end

    def index_line
      vector.to_a
    end
  end
end
