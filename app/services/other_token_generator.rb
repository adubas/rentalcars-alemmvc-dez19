class OtherTokenGenerator
  def self.generate
    charset = Array('A'..'Z') + Array(0..9) + Array('a'..'z')
    Array.new(8) { charset.sample }.join
  end
end