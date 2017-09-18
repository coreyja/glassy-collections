# frozen_string_literal: true

class Photo < ApplicationRecord
  belongs_to :user

  has_attached_file :photo, styles: {
    medium: '300x300>',
    thumb: '100x100>',
  }, default_url: ActionController::Base.helpers.image_path("missing.png")
  process_in_background :photo

  validates_attachment_content_type :photo, content_type: %r{\Aimage/.*\Z}
  validates_attachment_presence :photo

  delegate :url, to: :photo

  def data_uri(_style = nil)
    base64 = Base64.encode64(Paperclip.io_adapters.for(photo).read.to_s).gsub(/\s+/, '')
    "data:#{photo.content_type};base64,#{Rack::Utils.escape(base64)}"
  end
end
