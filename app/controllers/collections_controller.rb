# frozen_string_literal: true

class CollectionsController < ApplicationController
  before_action :require_login, only: %i(edit update new create)

  def show
    @collection = Collection.find(params[:id])
  end

  def new
    @collection = current_user.collections.new
  end

  def create
    Collection.transaction do
      @collection = Collection.new
      if @collection.update update_params
        @collection.owners << current_user
        redirect_to collection_path(@collection)
      else
        render :new
      end
    end
  end

  def edit
    @collection = current_user.collections.find(params[:id])
    render :new
  end

  def update
    @collection = current_user.collections.find(params[:id])
    if @collection.update update_params
      redirect_to collection_path(@collection)
    else
      render :new
    end
  end

  private

  def update_params
    params.require(:collection).permit(:name)
  end
end
