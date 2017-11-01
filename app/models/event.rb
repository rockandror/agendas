class Event < ActiveRecord::Base

  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user }

  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  # Relations
  belongs_to :user
  belongs_to :position
  has_many :participants, dependent: :destroy
  has_many :positions, through: :participants
  has_many :attachments, dependent: :destroy
  has_many :attendees, dependent: :destroy

  # Validations
  validates_presence_of :title, :position
  validate :participants_uniqueness
  validate :position_not_in_participants, if: -> { position.present? }

  # Nested models
  accepts_nested_attributes_for :attendees, :reject_if => :all_blank, :allow_destroy => true
  accepts_nested_attributes_for :attachments, :reject_if => :all_blank, :allow_destroy => true
  accepts_nested_attributes_for :participants, :reject_if => :all_blank, :allow_destroy => true

  def participants_uniqueness
    participants = self.participants.reject(&:marked_for_destruction?)
    unless participants.map{|x| x.position_id}.uniq.count == participants.to_a.count
      errors.add(:base, I18n.t('backend.participants_uniqueness'))
    end
  end

  def position_not_in_participants
    participants = self.participants.reject(&:marked_for_destruction?).map{|x| x.position_id}
    errors.add(:base, I18n.t('backend.position_not_in_participants')) if participants.include? position.id
  end

  searchable do

    text :title, :description
    time :scheduled

    text :area_title do
      self.position.area.title
    end

    integer :area_id do
      self.position.area.id
    end

    text :holder_name do
      self.position.holder.full_name if self.position.holder.present?
    end

    integer :holder_id do
      self.position.holder.id if self.position.holder.present?
    end

    text :holder_position do
      self.position.title
    end

    text :attendee_name do
      [self.attendees.map{|attendee| attendee.name },self.attendees.map{|attendee| attendee.company}]
    end

  end

end
