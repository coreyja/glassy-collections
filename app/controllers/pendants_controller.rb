# frozen_string_literal: true
class PendantsController < ApplicationController
  def show
    @pendant = Pendant.where(collection_id: params[:collection_id]).find(params[:id])
  end
end
