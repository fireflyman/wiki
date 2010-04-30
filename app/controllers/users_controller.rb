class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  #include AuthenticatedSystem
  before_filter :load_user, :only => [:show, :edit, :update, :destroy]
  before_filter :new_user, :only => :new
  filter_access_to :all
  filter_access_to [:show, :edit, :update], :attribute_check => true
  #这里涉及到两个名词:粗粒度与细粒度.
   #粗粒度:表示类别级,只检查对象的类别（Class）,而不追究其某一个特定的实例.
   #细粒度:表示实例级,即需要考虑具体对象的实例(Instance).比如,只有本人才能查看与
   #编辑自己的用户资料.这个我们通过比较ID或某个特定的属性可以实现,
   #因此:arrtibute_check => true(开启属性检查)就是为这准备的.

  def index
   @users = User.find(:all)
  end
  
  # render new.rhtml
  def new
   # @user = User.new
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
            # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_user = @user # !! now logged in
     # redirect_back_or_default('/')
      redirect_to users_url
      flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end
  
  def show
  end
  
  def edit
  end
  
  def update
   if @user.update_attributes(params[:user])
      flash[:notice] = "更新用戶成功."
      redirect_to @user
    else
      render :action => 'edit'
    end
   end 
    def destroy
     @user.destroy
     flash[:notice] = "刪除用戶成功."
     redirect_to users_url
    end
  
  protected

 def load_user
  @user = User.find(params[:id])
 end
 
 def new_user
  @user = User.new
 end
 
 def permission_denied 
    respond_to do |format| 
      flash[:error] = '对不起，您没有足够的权限访问此页！' 
      format.html { redirect_to request.referer } 
      format.xml  { head :unauthorized } 
      format.js   { head :unauthorized } 
    end 
 end 

end
