class User < ActiveRecord::Base
  extend Enumerize
  enumerize :level, in: [:one, :two]
  enumerize :working_form, in: [:full, :part]

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

  def update_github_account_with_auth_hash!(auth_hash)
    self.github_auth_hash = auth_hash.to_h
    self.github_email     = auth_hash['info']['email']
    self.github_id        = auth_hash['uid']
    self.github_token     = auth_hash['credentials']['token']
    self.github_login     = auth_hash['extra']['raw_info']['login']
    self.save!
  end

  def github_connected?
    github_id.present?
  end

  def update_credentials(oauth_data)
    self.update_column(:token, oauth_data.credentials.token)
  end

  def post_remotty_comment(comment)
    Remotty::User.me(self.token).participation.post_comment(comment)
  end

end
