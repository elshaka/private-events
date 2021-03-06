class Event < ApplicationRecord
  belongs_to :host, class_name: 'User'
  has_many :attendances
  has_many :attendees, through: :attendances, source: :user

  scope :upcoming, -> { where('date >= ?', Time.now) }
  scope :past, -> { where('date < ?', Time.now) }

  validates :date, presence: true
  validates :description, presence: true, length: { maximum: 255 }
end
