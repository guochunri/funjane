class Product < ApplicationRecord
  validates :name, presence: { message: "请输入商品名称" }
  validates :price, presence: { message: "请输入商品售价" }
  validates :price, numericality: { greater_than: 0, message: "请输入商品售价，必须大于零" }
  validates :quantity, presence: { message: "请输入库存数量" }, numericality: { greater_than_or_equal: 0 }
  validates :category_id, presence: { message: "请选择商品分类" }
  validates :brand_id, presence: { message: "请选择商品品牌" }

  belongs_to :category
  belongs_to :brand
  has_many :product_images, dependent: :destroy
  accepts_nested_attributes_for :product_images
  has_many :wish_lists
  has_many :wish_list_owners, :through => :wish_lists, :source => :user
  has_one :order_item

  scope :published, -> { where(is_hidden: false) }
  scope :recent, -> { order('created_at DESC') }

  def publish!
    self.is_hidden = false
    self.save
  end

  def hide!
    self.is_hidden = true
    self.save
  end

  def hidden?
    is_hidden
  end

  # 精选商品 #
  def chosen!
    self.is_chosen = true
    self.save
  end

  def no_chosen!
    self.is_chosen = false
    self.save
  end

end
