class TokenGenerator
  def self.generate
    charset = Array('A'..'Z') + Array(0..9)
    Array.new(6) { charset.sample }.join
  end
end