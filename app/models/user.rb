class User
  include Mongoid::Document
  include Mongoid::Timestamps
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  ## Database authenticatable
  field :email,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""
  
  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String
  field :username
  field :uid
  field :provider
  field :token

  validates_presence_of :username
  validates_uniqueness_of :username, :email, :case_sensitive => false

  has_and_belongs_to_many :bills, :inverse_of => :users

  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :uid, :provider, :token, :creator

  def fb_profile_pic
    @graph = Koala::Facebook::API.new(self.token)
    @profile_image = @graph.get_picture("me")
  end


  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.info.nickname
      user.email = auth.info.email
      user.token = auth.credentials.token
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
        user.errors.delete(:password) if user.errors.has_key?(:password)
      end
    else
      super
    end

    # super.tap do |user|
    #   if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
    #     user.email = data.email if user.email.blank?
    #     user.username = data.username
    #     logger.debug "\n ### \n"
    #     logger.debug session["devise.facebook_data"]
    #     logger.debug "\n ### \n"
    #   end
    # end

  end

end
