class User < ActiveRecord::Base
	
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
  								:name, :profile_image, :first_name, :number

  # http://railscasts.com/episodes/163-self-referential-association
	has_many :friendships
	has_many :friends, :through => :friendships
	has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
	has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  has_many :given_reminders, :class_name => "Reminder", :foreign_key => "caller_id"
  has_many :reminders, :foreign_key => "callee_id"

end
