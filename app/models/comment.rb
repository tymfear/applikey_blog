class Comment < ApplicationRecord
  has_many :comments, dependent: :destroy
  
  belongs_to :user
  belongs_to :article
  belongs_to :comment, optional: true

  alias_attribute :parent, :comment
  alias_attribute :parent_id, :comment_id
  
  validate :parent_comment
  
  validates :body, presence: true, length: { maximum: 256 }
  
  default_scope { order id: :desc }
  
  private
  
  def parent_comment
    return if parent.blank?
    return if article_id == parent.article_id
    
    errors.add :parent, I18n.t('errors.comment.parent')
  end
end
