class Cart < ApplicationRecord
  has_many :cart_items
  has_many :products, through: :cart_items, source: :product

  # 加入购物车
  def add_product_to_cart(product,quantity)
    ci = cart_items.build
    ci.product = product
    ci.quantity = quantity
    ci.save
  end

  # 修改购物车 #
  # def update_product_to_cart(product,quantity)
  #   ci = cart_items.find_by(product)
  #   ci.quantity = quantity
  #   ci.save
  # end

  # 清空购物车
  def clear!
    cart_items.destroy_all
  end

  # 购物车总价
  def total_price
    sum = 0
    cart_items.each do |cart_item|
      if cart_item.product.price.present?
        sum += cart_item.quantity * cart_item.product.price
      end
    end
    sum
  end

end
