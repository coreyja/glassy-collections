# frozen_string_literal: true
module CurrentUser
  class PendantRecordsController < ApplicationController
    before_action :require_login

    def new
      @pendant_record = current_user.pendant_records.new
    end

    def create
      @pendant_record = current_user.pendant_records.new pendant_record_params
      if @pendant_record.save
        redirect_to new_my_pendant_record_photos_path(@pendant_record)
      else
        render :new
      end
    end

    def index
      @calendar = PendantRecordCalendar.new calendar_hash
    end

    private

    def calendar_hash
      {
        date: params[:date].try(:to_date) || Date.today,
        user: current_user,
      }
    end

    def pendant_record_params
      params.require(:pendant_record).permit(:pendant_id)
    end
  end
end
