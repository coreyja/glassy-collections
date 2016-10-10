# frozen_string_literal: true
class PendantRecordCalendar
  include HashAttributeAssignment

  REQUIRED_KEYS = %i(user date).freeze

  def days
    @days ||= date_range.map { |day| CalendarDay.new user: user, date: day, date_range: date_range }
  end

  def weeks
    @weeks ||= calendar_days.each_slice(7).to_a
  end

  def month
    date.strftime('%B')
  end

  def year
    date.strftime('%Y')
  end

  def first_of_month
    start_date
  end

  private

  attr_reader :user, :date

  def start_date
    @start_date ||= date.beginning_of_month
  end

  def end_date
    @end_date ||= date.end_of_month
  end

  def date_range
    start_date..end_date
  end

  def calendar_range
    calendar_start..calendar_end
  end

  def calendar_start
    start_date.beginning_of_week(:sunday)
  end

  def calendar_end
    end_date.end_of_week(:sunday)
  end

  def calendar_days
    calendar_range.map { |day| CalendarDay.new user: user, date: day, date_range: date_range }
  end

  class CalendarDay
    include HashAttributeAssignment

    REQUIRED_KEYS = %i(user date date_range).freeze

    attr_reader :date

    def pendant_records
      @pendant_records ||= user.pendant_records.worn_on(date).order('created_at ASC')
    end

    def enabled?
      date_range.include? date
    end

    def disabled?
      !enabled?
    end

    private

    attr_reader :user, :date_range
  end
end
