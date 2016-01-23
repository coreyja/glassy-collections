module CurrentUser
  class PendantRecordsController < ApplicationController
    before_action :require_login

    def new
      @pendant_record = current_user.pendant_records.new
      @pendants = current_user.pendants
    end

    def create
      @photo = current_user.photos.new photo_params
      @pendant_record = current_user.pendant_records.new pendant_record_params
      @pendant_record.photo = @photo
      if @photo.save && @pendant_record.save
        redirect_to action: :index
      else
        render :new
      end
    end

    def index
      @pendant_records = current_user.pendant_records.order('created_at DESC')
    end

    private

    def photo_params
      params.require(:pendant_record).permit(:photo)
    end

    def pendant_record_params
      params.require(:pendant_record).permit(:pendant_id)
    end
  end
end
