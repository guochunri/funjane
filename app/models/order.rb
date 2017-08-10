class Order < ApplicationRecord
  before_create :generate_token

  validates :billing_name, presence: true
  validates :billing_address, presence: true
  validates :shipping_name, presence: true
  validates :shipping_address, presence: true

  belongs_to :user
  has_many :order_items

  def generate_token
    self.token = SecureRandom.uuid # Ruby 內建亂序生成器
  end

end
