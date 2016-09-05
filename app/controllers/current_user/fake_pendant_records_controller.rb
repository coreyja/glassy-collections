module CurrentUser
  class FakePendantRecordsController < ApplicationController
    before_action :require_login

    def new
      @pendant_record = current_user.pendant_records.new
      @pendants = current_user.wearable_pendants
    end

    def create
      @pendant_record = current_user.pendant_records.new
      if @pendant_record.update pendant_record_params
        redirect_to my_pendant_records_path
      else
        @pendants = current_user.wearable_pendants
        render :new
      end
    end

    private

    def pendant_record_params
      params.require(:pendant_record).permit(:pendant_id, :worn_on)
    end
  end
end
