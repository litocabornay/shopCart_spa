class Order < ApplicationRecord
  belongs_to :order_status, optional: true
  has_many :order_items


  before_create :set_order_status
  before_save :update_subtotal

  def subtotal
    order_items.collect { |oi| oi.valid? ? (oi.quantity * oi.unit_price) : 0 }.sum
  end

  def total
  	if subtotal > 70
  		discount = 12
  		subtotal - ( discount.to_f / 100 * subtotal )
  	else
  		subtotal
  	end
  end
private
  def set_order_status
    self.order_status_id = 1
  end

  def update_subtotal
    self[:subtotal] = subtotal
  end

  def update_total
  	self[:total] = total
  end
end
