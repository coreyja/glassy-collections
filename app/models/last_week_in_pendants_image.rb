require 'render_anywhere'

class LastWeekInPendantsImage
  include HashAttributeAssignment
  include RenderAnywhere

  delegate :to_png, :to_jpeg, to: :image_kit

  def html
    @html ||= render partial: 'last_week_in_pendants/last_week_in_pendants',locals: { pendant_records_by_day: pendant_records_by_day }
  end

  private

  attr_reader :user

  def image_kit
    @image_kit ||= IMGKit.new(html, quality: 100)
  end

  def pendant_records_by_day
    @pendant_records_by_day ||= day_range.map do |day|
      {
        day: start_date + day.days,
        pendants: user.pendant_records.on_date(start_date + day.days)
      }
    end
  end

  def start_date
    Time.zone.today - 7.days
  end

  def end_date
    Time.zone.today
  end

  def day_range
    0..(end_date.to_date - start_date.to_date).to_i
  end
end
