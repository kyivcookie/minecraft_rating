class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  acts_as_commenter
  acts_as_votable
  acts_as_voter


  def can_vote?
    self.voted_at + (60*24) < Time.now.to_i
  end
end
