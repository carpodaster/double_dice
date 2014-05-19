class DoubleDice
  class Matrix < Struct.new(:cleartext, :password)

    def to_a
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
      last_line = fill_last_line(line)
      matrix << last_line unless last_line.empty?
      matrix
    end

    private

    def fill_last_line(line)
      (password.size - line.size).times do
        line << '_'
      end
      line
    end

    def index_line
      PasswordVector.new(password).to_a
    end
  end
end
