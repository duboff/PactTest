class Order
  DEFAULT_PRICE = 6.95

  attr_accessor :user, :price

  def initialize(user)
    @user = user
    @price = DEFAULT_PRICE
  end

  def billed_for
    if voucher && voucher.instant?
      instant_bill
    elsif user.voucher
      apply_voucher
    else 
      price
    end
  end

  def voucher
    user.voucher
  end

  def instant_bill
    multi_price = voucher.multi_bill(price)
    reset_voucher
    multi_price
  end

  def apply_voucher
    price - voucher.billed_for(price)
  end

  def reset_voucher
    user.voucher = Voucher.create(:default, credit: price * user.voucher.number)
  end

end