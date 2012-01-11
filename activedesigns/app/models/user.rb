require 'digest/sha1'
class User < ActiveRecord::Base
  
  has_many :projects, :dependent => :destroy
  has_many :images, :through => :projects, :dependent => :destroy
  
  mount_uploader :avatar, AvatarUploader
  mount_uploader :logo, LogoUploader
  
  #paperclip 
  #has_attached_file :photo, :styles => { 
  #    :small => {:geometry => "80x80>", :processors => [:cropper] },
  #    :list => {:geometry => "100x100>", :processors => [:cropper] }, 
  #    :thumb => {:geometry => "165x165>", :processors => [:cropper] }, 
  #   :large => "600x600>"
  #  },
    #:processors => [:cropper],
  #  :url => "/assets/:class/:attachment/:id/:style/:filename",
  #  :path => ":rails_root/public/assets/:class/:attachment/:id/:style/:filename"
    
  attr_accessor :password, :crop_x, :crop_y, :crop_w, :crop_h, :crop_logo_x, :crop_logo_y, :crop_logo_w, :crop_logo_h
  attr_protected :hashed_password, :salt
      
  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i  
  #paperclip validates_attachment_presence :photo
  #paperclip validates_attachment_size :photo, :less_than => 5.megabytes
  #paperclip validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png', 'image/gif']
  
  validates :first_name, :presence => true, :length => { :maximum => 25 }
  validates :last_name, :presence => true, :length => { :maximum => 50 }
  validates :username, :length => { :within => 8..25 }, :uniqueness => true
  validates :subdomain_name, :uniqueness => true
  validates :email, :presence => true, :uniqueness => true, :length => { :maximum => 100 }, 
    :format => EMAIL_REGEX, :confirmation => true
  # only on create, so other attributes of this user can be changed
  validates_length_of :password, :within => 8..25, :on => :create


  before_save :create_hashed_password
  after_save :clear_password
  after_update :crop_avatar, :crop_logo
  #paperclip after_update :reprocess_photo, :if => :cropping?
  
  def crop_logo
    logo.recreate_versions! if crop_logo_x.present?
  end
  
  def crop_avatar
    avatar.recreate_versions! if crop_x.present?
  end
  
  
  scope :named, lambda {|first,last| where(:first_name => first, :last_name => last)}
  scope :sorted, order("users.last_name ASC, users.first_name ASC")
  
  def name
    "#{first_name} #{last_name}"
  end
  
  def self.create_cpanel_acct
  	require 'lumberg'
	server = Lumberg::Whm::Server.new(:host => '184.154.137.146', :user => 'connectt', :hash => 'dmm12w99', :basic_auth => true)
	
	
result = server.account.create(
  :username => 'kingpang',
  :domain   => 'kingpangilinan.com',
  :password => 'thesuperpassword123',
  :plan => 'connectt_connect1'
)

return result.inspect
	
  end
  
  
  def self.has_header
  	return false
  end
  
  #for adds purposes
  def self.max_img(img_cap=30, fb_like=false)
  	if fb_like
  		return img_cap + 10
    else
    	return img_cap
  	end
  end
  
  def self.max_proj(proj_cap=3, fb_like=false)
  	if fb_like
  		return proj_cap + 1
    else
    	return proj_cap
  	end
  end
  #for adds purposes end
  
  def self.del_validated(cur_user, session_user, request_user_del)
  	session_user == cur_user && cur_user == request_user_del
  end
  
  
  
  def self.authenticate(username="", password="")
    user = User.find_by_username(username)
    if user && user.password_match?(password)
      return user
    else
      return false
    end
  end

  # The same password string with the same hash method and salt
  # should always generate the same hashed_password.
  def password_match?(password="")
    hashed_password == User.hash_with_salt(password, salt)
  end
  
  def self.make_salt(username="")
    Digest::SHA1.hexdigest("Use #{username} with #{Time.now} to make salt")
  end
  
  def self.hash_with_salt(password="", salt="")
    Digest::SHA1.hexdigest("Put #{salt} on the #{password}")
  end
  
  #paperclip 
  #def photo_geometry(style = :original)
  #  @geometry ||= {}
  #  @geometry[style] ||= Paperclip::Geometry.from_file(photo.path(style))
  #end
  #def cropping?
  #  !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  #end
  

  
  
  # user retrive password (password reset)
  before_create { generate_token(:auth_token) }
  
  def create_retrive_pass
  	user = User.find_by_email(params[:email])
  	user.send_password_reset if user
  	redirect_to root_url, :notice => "Email sent with password reset instructins."
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.base64.tr("+/", "-_")
    end while User.exists?(column => self[column])
  end
  # END user retrive password (password reset)
	
	private
  
  def create_hashed_password
    # Whenever :password has a value hashing is needed
    unless password.blank?
      # always use "self" when assigning values
      self.salt = User.make_salt(username) if salt.blank?
      self.hashed_password = User.hash_with_salt(password, salt)
    end
  end

  def clear_password
    # for security and b/c hashing is not needed
    self.password = nil
  end

  #paperclip 
  #def reprocess_photo
  #  photo.reprocess!
  #end
			
end
