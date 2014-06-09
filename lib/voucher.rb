class Voucher
  attr_accessor :credit, :type, :discount, :number, :instant

  alias :instant? :instant

  def initialize(type, *attrs)
    @type = type
    case @type
      when :default
        @credit = attrs.first[:credit]
      when :discount
        @discount = attrs.first[:discount] / 100.0
        @number = attrs.first[:number]
        @instant = attrs.first[:instant]
    end
  end

  def billed_for(price)
    case self.type
    when :default
      a = [price, credit].min
      self.credit -= a
      a
    when :discount
      a = [1, self.number].min
      self.number -= 1
      price * discount * a
    end
  end
end