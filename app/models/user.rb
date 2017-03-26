class User < ApplicationRecord
  has_secure_password

  has_many :articles
  has_many :comments

  validates :password, length: { minimum: 8, maximum: 64 }, allow_nil: true
  validates :email, :username, presence: true, uniqueness: true
  validates :email, format: EMAIL_REGEX, length: { maximum: 64 }
  validates :username, length: { maximum: 16 }

  validate :avatar_data_size
  
  delegate :convert, to: Custom::Helpers::Base64FromFile, prefix: :avatar

  def avatar=(file)
    self.avatar_data = avatar_convert file
  end

  private

  def avatar_data_size
    return if avatar_data.blank?

    if avatar_data.bytesize > 2.megabytes
      errors.add :avatar, I18n.t('errors.user.avatar')
    end
  end
end
