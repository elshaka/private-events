class User < ApplicationRecord
  has_many :hosted_events, class_name: 'Event', foreign_key: :host_id
  has_many :attendances
  has_many :attending_events, through: :attendances, source: :event

  validates :name, presence: true, length: { maximum: 50 }
  validates :username, presence: true, length: { maximum: 16 },
                       uniqueness: { case_sensitive: false }

  before_save :downcase_username

  def join_event(event)
    return false if attending_events.include? event
    attending_events << event
  end

  def leave_event(event)
    return false unless attending_events.include? event
    attending_events.destroy event
  end

  def attending?(event)
    attending_events.include? event
  end

  private

  def downcase_username
    self.username = username.downcase
  end
end
