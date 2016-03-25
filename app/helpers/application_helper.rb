module ApplicationHelper
  def raw_asset(asset)
    raw Rails.application.assets[asset].to_s
  end
end
