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
  # 更新付款方式栏位
  def set_payment_with!(method)
    self.update_columns(payment_method: method)
  end

  # 更新状态栏位：已付款
  def pay!
    self.update_columns(is_paid: true)
  end

  # AASM 订单状态
  include AASM

  # 定义状态
  aasm do
    state :order_placed, initial: true
    state :paid
    state :shipping_name
    state :shipped
    state :order_cancelled
    state :good_returned

    # 付款
    event :make_payment, after_commit: :pay! do
      # 状态更改为：已付款
      transitions from: :order_placed, to: :paid
    end

    # 出货
    event :ship do
       # 状态更改为：已出货
      transitions from: :paid, to: :shipping
    end

    # 到货
    event :deliver do
       # 状态更改为：已到货
      transitions from: :shipping, to: :shipped
    end

    # 退货
    event :return_good do
       # 状态更改为：已退货
      transitions from: :shipped, to: :good_returned
    end

    # 取消订单
    event :cancel_order do
      # 状态更改为：订单已取消
      transitions from: [:order_placed, :paid], to: :order_cancelled
    end

  end

end
