class Server < ActiveRecord::Base
  mount_uploader :banner, BannerUploader
  # acts_as_commontator
  acts_as_votable
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

  has_many :payments

  def get_status
    [
        label: self.status ? 'success' : 'danger',
        status: self.status ? 'online' : 'offline',
    ]
  end

  # def get_server_status
  #   status = MinecraftPing.new(self.ip, self.port ? self.port : nil, self).check
  #   if self.cache_time.to_i < Time.now.to_i
  #     if status
  #       self.protocol       =   status[:protocol]
  #       self.server_version =   status[:minecraft_version]
  #       self.description    =   status[:motd]
  #       self.players        =   status[:current_players]
  #       self.max_players    =   status[:max_players]
  #       self.status         =   1
  #     else
  #       self.status = 0
  #     end
  #     self.cache_time = Time.now.to_i + (60*10)
  #     self.save
  #     set_server_vars 0
  #   status
  #   else
  #     self.save
  #     set_server_vars
  #   end
  # end

  def get_server_status
    if self.cache_time < Time.now.to_i
      status = MinecraftPing.new(self.ip, self.port ? self.port : nil, 1).check
      # raise status.inspect
      if status != nil
        self.protocol       =   status[:protocol]
        self.server_version =   status[:minecraft_version]
        self.description    =   status[:motd]
        self.players        =   status[:current_players]
        self.max_players    =   status[:max_players]
        self.status         =   1
        set_server_cache
        self.save!
        set_server_vars
      else
        set_server_offline
        set_server_cache
        set_server_vars nil
      end
    else
      set_server_vars
    end
  end

  def set_server_cache
    self.cache_time = Time.now.to_i + (60*10)
  end

  def set_server_offline
    self.max_players = 0
    self.players = 0
    self.status = 0
    self.save

    set_server_vars nil
  end

  def set_server_vars(status = 1)
    {
        :status             => status ? 1 : 0,
        :protocol_version   => self.protocol,
        :minecraft_version  => nil,
        :label              => status ? 'success' : 'danger',
        :status_text        => status ? 'online'  : 'offline',
        :motd               => self.description,
        :current_players    => status ? self.players : 0,
        :max_players        => status ? self.max_players : 0
    }
  end

  def get_category
    Category.find self.category_id
  end
end
