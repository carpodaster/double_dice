module DoubleDice
  class Input # TODO rename me

    attr_reader :cleartext, :password

    def initialize(cleartext: cleartext, password: password)
      @cleartext = cleartext.to_s.upcase.strip.split(//).select{|c| /[A-Z]/ =~ c}
      @password  = password.to_s.upcase.strip.gsub(/\s/, '').split(//)
    end

    def matrix
      DoubleDice::Matrix.new(cleartext, password)
    end
  end
end
