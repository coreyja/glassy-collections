class Pendant < ActiveRecord::Base
  belongs_to :user
  belongs_to :artist

  has_many :pendant_records

  def to_s
    name
  end
end
