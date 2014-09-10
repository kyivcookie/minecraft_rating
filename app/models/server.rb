class Server < ActiveRecord::Base
  mount_uploader :banner, BannerUploader
  # acts_as_commontator
  acts_as_commontable

  validates :ip,
            :port,
            :name,
            :protocol,
            :presence => true

  validates :banner,
            :presence => true

  validates_integrity_of :banner
  validates_processing_of :banner

  def get_status
    [
        label: self.status ? 'success' : 'danger',
        status: self.status ? 'online' : 'offline',
    ]
  end

  def get_server_status
    if self.cache_time.to_i < Time.now.to_i
      status = MinecraftPing.new(self.ip, self.port ? self.port : nil).ping
      if status
        self.protocol       =   1
        self.server_version =   status[:minecraft_version]
        self.description    =   status[:motd]
        self.players        =   status[:current_players]
        self.max_players    =   status[:max_players]
        self.status         =   1
      else
        self.status = 0
      end
      self.cache_time = Time.now + (60*10)
      self.save
    status
    else
      self.save
      self.set_server_vars
    end
  end

  def set_server_vars
    {
        :protocol_version   => self.protocol,
        :minecraft_version  => nil,
        :motd               => self.description,
        :current_players    => self.players,
        :max_players        => self.max_players
    }
  end

  def get_category
    Category.find self.category_id
  end
end
