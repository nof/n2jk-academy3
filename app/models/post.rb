class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  acts_as_readable on: :created_at
  after_create :deliver

  validates :body, presence: true

  def deliver
    UserMailer.post_created(self).deliver_later!
  end
end
