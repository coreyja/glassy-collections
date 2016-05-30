module CurrentUser
  class PendantRecordsController < ApplicationController
    before_action :require_login

    def new
      @pendant_record = current_user.pendant_records.new
      @pendants = current_user.wearable_pendants
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
      @pendant_records = current_user.pendant_records.from_date(from_date).till_date(till_date).order('created_at DESC')
    end

    private

    def from_date
      from_date_string = params.fetch(:from_date, Date.today.to_s)
      Date.parse(from_date_string).at_beginning_of_month
    end

    def till_date
      till_date_string = params[:till_date]
      if till_date_string.present?
      from_date + 1.month
    end

    def photo_params
      params.require(:pendant_record).permit(:photo)
    end

    def pendant_record_params
      params.require(:pendant_record).permit(:pendant_id)
    end
  end
end
