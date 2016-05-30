class PendantRecordCalendar
  include HashAttributeAssignment

  DEFAULT_HASH = {
      duration: 1.month
  }.freeze
  REQUIRED_KEYS = %i(user)

  validate_hash ->(hash) { hash[:duration] >= 1.day }, message: 'Duration must be at least 1 day'

  def pendant_records
    @pendant_records ||= user.pendant_records.from_date(from_date).till_date(till_date).order('created_at DESC')
  end

  private

  attr_reader :user, :till_date_string, :from_date_string, :duration

  def from_date
    @from_date ||= begin
      if from_date_string.present?
        Date.parse(from_date_string)
      elsif till_date_string.present?
        till_date - duration
      else
        Time.zone.now.at_beginning_of_month
      end
    end
  end

  def till_date
    @till_date ||= begin
      if till_date_string.present?
        Date.parse(till_date_string)
      else
        from_date + duration
      end
    end
  end
end