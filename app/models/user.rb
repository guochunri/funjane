class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :name, presence: { message: "请输入用戶名" }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :orders
  has_many :wish_lists
  has_many :wish_list_items, :through => :wish_lists, :source => :product

  def admin?
    is_admin
  end

  # 将该商品加入愿望清单
  def add_to_wish_list!(product)
    wish_list_items << product
  end

   # 从愿望清单上刪除该商品
  def remove_from_wish_list!(product)
    wish_list_items.delete(product)
  end

  def is_wish_list_owner_of?(product)
    wish_list_items.include?(product)
  end

end
