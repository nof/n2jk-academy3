class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  acts_as_readable on: :created_at

  validates :body, presence: true
end
