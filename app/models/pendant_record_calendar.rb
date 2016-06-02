class PendantRecordCalendar
  include HashAttributeAssignment

  DEFAULT_HASH = {
    duration: 1.month
  }.freeze
  REQUIRED_KEYS = %i(user).freeze

  validate_hash ->(hash) { hash[:duration] >= 1.day }, message: 'Duration must be at least 1 day'
  validate_hash ->(hash) { hash.keys.include?(:from_date) || hash.keys.include?(:till_date) },
                message: 'Must specify a from_date or a till_date'

  def pendant_records
    @pendant_records ||= user.pendant_records.from_date(from_date).till_date(till_date).order('created_at DESC')
  end

  private

  attr_reader :user, :duration

  def from_date
    @from_date ||= till_date - duration
  end

  def till_date
    @till_date ||= from_date + duration
  end
end
