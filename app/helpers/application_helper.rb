module ApplicationHelper
  def get_setting(key)
    Settings.find(key).value
  end

  def get_settings
    Hash[Settings.all.map {|s| [s.key, s.value]}].symbolize_keys
  end
end
