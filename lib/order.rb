class Order
  DEFAULT_PRICE = 6.95

  attr_accessor :user

  def initialize(user)
    @user = user
  end

  def billed_for
    price = DEFAULT_PRICE
    if user.voucher
      price - user.voucher.billed_for(price)
    else
      price
    end
  end
end