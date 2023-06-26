class Project < ApplicationRecord
  belongs_to :user
  has_many :posts, dependent: :destroy
  has_many :comments
  has_many :documents, dependent: :destroy
end
