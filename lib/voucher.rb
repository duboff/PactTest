class Voucher
  attr_accessor :credit, :type

  def initialize(type, *attrs)
    case type
      when :default
        @credit = attrs.first[:credit]
    end
  end

  def billed_for(price)
    a = [price, credit].min
    self.credit -= a
    a
  end
end