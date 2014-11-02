class Room < ActiveRecord::Base
  extend FriendlyId

  has_many :reviews, dependent: :destroy
  belongs_to :user

  scope :most_recent, -> { order(created_at: :desc) }

  validates_presence_of :title, :location, :description, :slug
  validates_length_of :description, minimum: 30, allow_blank: false

  friendly_id :title, use: [:slugged, :history]

  def complete_name
    "#{title}, #{location}"
  end

  def self.search(query)
    if query.present?
      params = 'location LIKE :query OR title LIKE :query OR description LIKE :query'
      where([params, query: "%#{query}%"])
    else
      all
    end
  end
end
