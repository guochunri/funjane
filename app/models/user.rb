class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :orders
  has_many :wish_lists
  has_many :wish_list_items, :through => :wish_lists, :source => :product

  def admin?
    is_admin
  end

  def is_wish_list_owner_of?(product)
    wish_list_items.include?(product)
  end

end
