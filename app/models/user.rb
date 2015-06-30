class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  acts_as_reader

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

  def post_remotty_comment(comment)
    Remotty::User.me(self.token).participation.post_comment(comment)
  end

end
