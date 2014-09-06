module DoubleDice
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
