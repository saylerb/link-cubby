class Link < ApplicationRecord
  belongs_to :user

  default_scope { order('lower(title) DESC') }

  validates :url, :url => true
end
