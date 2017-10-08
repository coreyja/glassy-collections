# frozen_string_literal: true
module CurrentUser
  class PendantRecordPhotosController < ApplicationController
    before_action :require_login

    def new
      @pendant_record = current_user.pendant_records.find(pendant_record_id)
      @photo = Photo.new
    end

    def create
      @pendant_record = current_user.pendant_records.find(pendant_record_id)
      @photo = Photo.new photo_params
      @pendant_record.photo = @photo
      if @pendant_record.save
        redirect_to my_pendant_records_path
      else
        render :new
      end
    end

    private

    def pendant_record_id
      params[:pendant_record_id]
    end

    def photo_params
      params.require(:photo).permit(:photo).merge(user: current_user)
    end
  end
end
