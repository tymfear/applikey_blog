class Comment < ApplicationRecord
  has_many :children, class_name: 'Comment', dependent: :destroy

  belongs_to :user
  belongs_to :article
  belongs_to :parent, class_name: 'Comment',
             foreign_key: :comment_id, optional: true

  validate :parent_comment

  validates :body, presence: true, length: { maximum: 256 }

  default_scope { order id: :desc}

  scope :by_article, -> (id) { where article_id: id }
  scope :top, ->  { where comment_id: nil }

  private

  def parent_comment
    return if parent.blank?

    unless article_id.eql? parent.article_id
      errors.add :parent, 'comment should belong to the same article'
    end
  end
end
