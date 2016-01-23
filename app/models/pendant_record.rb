class PendantRecord < ActiveRecord::Base
  belongs_to :user
  belongs_to :pendant
  belongs_to :photo
end
