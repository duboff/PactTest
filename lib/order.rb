class Order
  DEFAULT_PRICE = 6.95

  attr_accessor :user

  def initialize(user)
    @user = user
  end

  def billed_for
    price = DEFAULT_PRICE
    if user.voucher
      if user.voucher.instant?
        user.voucher.credit = price * (user.voucher.number - 1)
        price = user.voucher.number * (price - user.voucher.billed_for(price))
        user.voucher.instant = false
        user.voucher.type = :default
      else
        price -= user.voucher.billed_for(price)
      end
    end
    price
  end
end