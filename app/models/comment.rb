class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  acts_as_readable on: :created_at
  after_create :deliver

  validates :body, presence: true

  def deliver
    UserMailer.comment_created(self).deliver_later!
  end
end
