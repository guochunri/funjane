class Category < ApplicationRecord
  validates :name, presence: true
  
  belongs_to :category_group
  has_many :products
end
