class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :project
  belongs_to :user

  validates :content, :user_id, :post_id, :project_id, presence: true
end
