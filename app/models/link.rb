class Link < ApplicationRecord
  belongs_to :user

  default_scope { order('lower(title) DESC') }

  validates :title, presence: true
  validates :url, :url => true
  validates :url, presence: true
end
