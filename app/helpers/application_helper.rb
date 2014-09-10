module ApplicationHelper
  def get_setting(key)
    Settings.find(key).value
  end
end
