class Play < ApplicationRecord
  belongs_to :user
  belongs_to :category
  validates :title, presence: true
  validates :description, presence: true
  validates :director, presence: true
  validates :category_id, presence: true

  has_attached_file :avatar, styles: { medium: "250x350>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
end

