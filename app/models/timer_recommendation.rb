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

  def milliseconds
    previous_dabs.first&.milliseconds
  end

  def previous_dabs
    nail.dabs.merge(user.dabs).order('created_at DESC').limit(10)
  end
end
