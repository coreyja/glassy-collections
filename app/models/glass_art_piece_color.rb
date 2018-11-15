# frozen_string_literal: true

class GlassArtPieceColor < ApplicationRecord
  belongs_to :glass_art_piece
  belongs_to :color
end
