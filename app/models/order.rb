class Order < ApplicationRecord
  before_create :generate_token

  validates :billing_name, presence: true
  validates :billing_address, presence: true
  validates :shipping_name, presence: true
  validates :shipping_address, presence: true

  belongs_to :user
  has_many :order_items

  def generate_token
    self.token = SecureRandom.uuid # Ruby 內建乱序生成器
  end

  # 付款 #
  # 更新付款方式
  def set_payment_with!(method)
    self.update_columns(payment_method: method)
  end

  # 更新狀態為：已付款
  def pay!
    self.update_columns(is_paid: true)
  end

end
