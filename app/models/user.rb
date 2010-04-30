require 'digest/sha1'

class User < ActiveRecord::Base
  #using_access_control
  #开启模型级别的访问控制,系统就会根据你的权限重写查询指令,防止数据被非法操纵.
  #视图级别的访问控制,直接封杀页面上的链接.相对应,控制器级别的访问控制是
  #封杀地址栏的url,模型级别的访问控制是来对待黑客的.前两个可能是误操作引起的,最后一种肯定来者不善
  
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken

  has_many :coauthors
  has_many :lemmas, :through => :coauthors
  validates_presence_of     :login
  validates_length_of       :login,    :within => 3..40
  validates_uniqueness_of   :login
  validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message

  validates_format_of       :name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of       :name,     :maximum => 100

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message

  

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :name, :password, :password_confirmation, :role



  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find_by_login(login.downcase) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end

  #protected

 def role_symbols
   @role_symbols ||= (role || []).map {|r| r.to_sym}
 end


end
