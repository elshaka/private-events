class User < ApplicationRecord
  has_many :hosted_events, class_name: 'Event', foreign_key: :host_id
  has_many :attendances
  has_many :attending_events, through: :attendances, source: :event

  validates :name, presence: true, length: { maximum: 50 }
  validates :username, presence: true, length: { maximum: 16 },
                       uniqueness: { case_sensitive: false }

  before_save :downcase_username

  private

  def downcase_username
    self.username = username.downcase
  end
end
