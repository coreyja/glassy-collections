class Color < ApplicationRecord
  belongs_to :artist_group

  has_many :glass_art_piece_colors
  has_many :glass_art_pieces, through: :glass_art_piece_colors
end
