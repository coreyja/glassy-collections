class User < ActiveRecord::Base
  include Clearance::User

  has_many :nails
  has_many :dabs

  has_many :pendants
  has_many :pendant_records

  has_many :photos

  has_many :ownded_crews, class_name: 'Crew'

  has_many :crew_memberships
  has_many :crews, through: :crew_memberships

  has_many :push_notification_subscriptions, dependent: :destroy
  has_many :authentications, dependent: :destroy

  scope :needs_reminder, -> { where.not(id: joins(:pendant_records).merge(PendantRecord.on_date(Time.zone.today))) }

  def self.create_from_omniauth!(auth_hash)
    create!(
      name: auth_hash[:info][:nickname],
      email: auth_hash[:info][:email],
    )
  end

  def wearable_pendants
    Pendant.where(id: wearable_pendant_ids)
  end

  def dabable_users
    User.where(id: dabable_user_ids)
  end

  def password_optional?
    true
  end

  def email_optional?
    true
  end

  def display_name
    if name.present?
      name
    else
      email
    end
  end

  private

  def wearable_pendant_ids
    pendants.ids + crews.map(&:pendants).map(&:ids).flatten
  end

  def dabable_user_ids
    [id] + ownded_crews.map(&:members).map(&:ids).flatten
  end
end
