class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy

  validates :room_id, :participation_id, presence: true

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.auth_hash = auth
      if info = auth['info']
        user.name = info['name']
        user.email = info['email']
        user.icon_url = info['icon_url']
        user.room_id = info['room_id']
        user.participation_id = info['participation_id']
      end
    end
  end

  def update_credentials(oauth_data)
    self.update_column(:token, oauth_data.credentials.token)
  end

end
