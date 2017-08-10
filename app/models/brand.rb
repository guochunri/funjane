class Brand < ApplicationRecord
  mount_uploader :logo, ImageUploader
  validates :name, presence: true
  has_many :products

  def publish!
    self.is_hidden = false
    self.save
  end

  def hide!
    self.is_hidden = true
    self.save
  end

end
