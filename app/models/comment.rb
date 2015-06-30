class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  acts_as_readable on: :created_at

  validates :body, presence: true
end
