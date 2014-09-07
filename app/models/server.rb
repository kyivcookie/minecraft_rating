class Server < ActiveRecord::Base
  mount_uploader :banner, BannerUploader
  # acts_as_commontator
  acts_as_commontable

  def get_status
    [
        label: self.status ? 'success' : 'error',
        status: self.status ? 'online' : 'offline',
    ]
  end
end
