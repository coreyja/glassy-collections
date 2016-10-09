# frozen_string_literal: true
class CrewMembership < ActiveRecord::Base
  belongs_to :crew
  belongs_to :user
end
