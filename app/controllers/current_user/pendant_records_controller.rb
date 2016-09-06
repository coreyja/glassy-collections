module CurrentUser
  class PendantRecordsController < ApplicationController
    before_action :require_login

    def new
      @pendant_record = current_user.pendant_records.new
      @pendants = filtered_pendants
    end

    def create
      @photo = current_user.photos.new photo_params
      @pendant_record = current_user.pendant_records.new pendant_record_params
      @pendant_record.photo = @photo if @photo.valid?
      if @pendant_record.save
        redirect_to action: :index
      else
        @pendants = current_user.wearable_pendants
        render :new
      end
    end

    def index
      @calendar = calendar
    end

    private

    def calendar_hash
      {
        date: params[:date].try(:to_date) || Date.today,
        user: current_user,
      }
    end

    def calendar
      PendantRecordCalendar.new calendar_hash
    end

    def filtered_pendants
      if filter_provided?
        current_user.wearable_pendants.search(filter_term)
      else
        current_user.wearable_pendants
      end
    end

    def photo_params
      params.require(:pendant_record).permit(:photo)
    end

    def pendant_record_params
      params.require(:pendant_record).permit(:pendant_id)
    end

    def pendant_filter_params
      params.fetch(:pendant_filter, {}).permit(:term)
    end

    def filter_provided?
      pendant_filter_params.present? && filter_term.present?
    end

    def filter_term
      pendant_filter_params[:term]
    end
  end
end
