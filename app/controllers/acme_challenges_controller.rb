class AcmeChallengesController < ApplicationController

  LETS_ENCRYPT_CHALLENGE_HASH = {
    '_qyOLxI-z8Ah-7XVfCF6fEeNg2-QNivnDLYQurY5NwA' =>
      '_qyOLxI-z8Ah-7XVfCF6fEeNg2-QNivnDLYQurY5NwA.JbhTJ2cmTjqgny1YE6MAzQFWFUkvDp6WU5rexIW0w2c'
  }.freeze

  def letsencrypt
    render text: LETS_ENCRYPT_CHALLENGE_HASH[id]
  end

  private

  def id
    params[:id]
  end
end
