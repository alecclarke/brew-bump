class Formula
  def self.[](_name)
    new
  end

  attr_reader :stable

  def initialize
    @stable = OpenStruct.new(
      url: "https://github.com/test-formula/archive/1.0.0.tar.gz",
      version: "1.0.0",
    )
  end
end
