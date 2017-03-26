class Article < ApplicationRecord
  has_many :comments, dependent: :destroy

  belongs_to :user

  validates :title, :body, presence: true
  validates :title, length: { maximum: 256 }
  validates :body, length: { maximum: 2048 }

  default_scope { order id: :desc }
end
