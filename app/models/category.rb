class Category < ApplicationRecord
  mount_uploader :logo, ImageUploader
  validates :name, presence: true

  belongs_to :category_group
  has_many :products

  scope :published, -> { where(is_hidden: false) }

  def publish!
    self.is_hidden = false
    self.save
  end

  def hide!
    self.is_hidden = true
    self.save
  end

end
