require_relative('../../lib/server_updater')

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

  def get_label
    self.status ? "<div class='label label-success'>#{get_status_text}" : "<div class='label label-success'>#{get_status_text}"
  end

  def get_status_text
    self.status ? 'online' : 'offline'
  end

  def get_server_status
    if self.cache_time < Time.now.to_i
      status = ServerUpdater.new(self.ip).ping

      if status != nil
        self.update(
            {
                status:1,
                server_version: status[0][:version_name],
                players: status[0][:players_online],
                max_players: status[0][:max_players],
                cache_time: set_server_cache
            }
        )
        self
      else
        self.update(
            {
                status:0,
                players: 0,
                cache_time: set_server_cache
            }
        )
        self
      end
    else
      self
    end
  end

  def set_server_cache
    Time.now.to_i + (60*10)
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
