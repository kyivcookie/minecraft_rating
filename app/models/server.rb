class Server < ActiveRecord::Base
  mount_uploader :banner, BannerUploader
  # acts_as_commontator
  acts_as_votable
  acts_as_commontable

  after_create :create_uptime

  validates :ip,
            :port,
            :name,
            :protocol,
            :presence => true

  validates :banner,
            :presence => true

  validates_integrity_of :banner
  validates_processing_of :banner

  belongs_to :user
  has_one :uptime
  has_many :payments
  has_many :servers_to_categories, :class_name => 'ServersToCategories'

  def get_status
    [
        label: self.status ? 'success' : 'danger',
        status: self.status ? 'online' : 'offline',
    ]
  end

  def create_uptime
    Uptime.create({up: 1,down:0, server_id: self.id})
  end

  def get_label
    self.status ? "<div class='label label-success'>#{get_status_text}" : "<div class='label label-danger'>#{get_status_text}"
  end

  def get_status_text
    self.status ? 'online' : 'offline'
  end

  # todo refactor
  def get_server_status
    self
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

  # def get_category
  #   Category.find self.category_id
  # end
end
