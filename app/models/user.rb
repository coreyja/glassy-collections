# frozen_string_literal: true

class User < ApplicationRecord
  include Clearance::User

  has_many :collection_owners, foreign_key: :owner_id
  has_many :collections, through: :collection_owners
  has_many :glass_art_pieces, through: :collections

  has_many :pendant_records

  has_many :photos

  has_many :push_notification_subscriptions, dependent: :destroy
  has_many :authentications, dependent: :destroy

  scope :needs_reminder, -> { where.not(id: joins(:pendant_records).merge(PendantRecord.worn_on(Time.zone.today))) }

  def self.create_from_omniauth!(auth_hash)
    create!(
      name: auth_hash[:info][:nickname],
      email: auth_hash[:info][:email] || "#{auth_hash[:info][:nickname]}@fake-oauth-email.instagram.dev"
    )
  end

  def password_optional?
    true
  end

  def display_name
    name || email
  end

  def recorded_pendant_today?
    pendant_records.where(worn_on: Time.zone.today).any?
  end
end
