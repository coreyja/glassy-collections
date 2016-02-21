class Photo < ActiveRecord::Base
  has_attached_file :photo, styles: {
    medium: '300x300>',
    thumb: '100x100>'
  }

  validates_attachment_content_type :photo, content_type: %r{\Aimage/.*\Z}

  def data_uri(style=nil)
    base64 = Base64.encode64(open(photo.url(style)).read.to_s).gsub(/\s+/, "")
    "data:#{photo.content_type};base64,#{Rack::Utils.escape(base64)}"
  end
end
