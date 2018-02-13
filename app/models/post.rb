class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :user_id, presence: true

  has_attached_file :image, styles: { medium: "640x"}

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validates :image, presence: true

end
