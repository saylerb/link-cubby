class Link < ApplicationRecord
  belongs_to :user

  scope :sort_by_params, -> (user, attribute, direction) {
    user.links.order("lower(#{attribute}) #{direction}")
  }

  validates :title, presence: true
  validates :url, :url => true
  validates :url, presence: true
end
