class TimerRecommendation
  include ActiveModel::Model

  attr_accessor :user, :nail

  def to_dab_params
    {
      user_id: user.id,
      nail_id: nail.id,
      milliseconds: milliseconds
    }
  end

  private

  def last_dab
    previous_dabs.first
  end

  def milliseconds
    if last_dab.present?
      last_dab.milliseconds * last_dab.rating_modifier
    end
  end

  def previous_dabs
    nail.dabs.merge(user.dabs).order('created_at DESC').limit(10)
  end
end
