class Voucher
  attr_accessor :credit, :type
  def self.create(type, *attrs)
    
    case type
      when :default
        DefaultVoucher.new(attrs.first[:credit])   
      when :discount
        if attrs.first[:instant]
          InstantDiscountVoucher.new(attrs.first[:discount], attrs.first[:number])
        else
          DiscountVoucher.new(attrs.first[:discount], attrs.first[:number])
        end
    end
  end

  def billed_for(price)
  end

  def instant?
    type == :instant
  end
 
end

class DefaultVoucher < Voucher
  
  attr_accessor :credit

  def initialize(credit)
     @credit = credit
     @type = :default
  end

  def billed_for(price)
    a = [price, credit].min
    self.credit -= a
    a
  end

end

class DiscountVoucher < Voucher

  attr_accessor :discount, :number

  def initialize(discount, number)
    @discount = discount / 100.0
    @number = number
    @type = :discount
  end
  
  def billed_for(price)
    a = [1, self.number].min
    self.number -= 1
    price * discount * a
  end

end

class InstantDiscountVoucher < DiscountVoucher

  attr_accessor :instant

  def initialize(discount, number)
    @discount = discount / 100.0
    @number = number
    @type = :instant
    @instant = true
  end

  def multi_bill(price)
    self.number * (price - self.billed_for(price))
  end

end














