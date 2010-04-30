# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
 before_filter :set_current_user
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  include AuthenticatedSystem
  helper_method :current_user, :logged_in?
  # Scrub sensitive parameters from your log
   filter_parameter_logging :password, :password_confirmation
   #修改application_controller,其中,current_user,logged_in?都是来自restful- authentication插件;
   #为了安全,我们还用了filter_parameter_logging方法,把像password这样敏感的字段从日志中过滤掉,以防黑客偷窥到！
   
   protected
 def set_current_user
   Authorization.current_user = current_user
 end
 #匿名User的源码,位于{RAILS_ROOT}/vendor\plugins\declarative_authorization\lib \declarative_authorization\authorization.rb里面
end
#在RBAC授权模型中,User与Session既是代表两个资源,也是两个重要元素.
#在一般的授权系统中,User是作为权限的拥用者或主体而存在，在 RBAC授权模型中,
#情况微有改变,精确来说,是权限的附加体或宿主.权限被移到我们一会儿提到的Role的身上.
#Session在RBAC中是比较隐晦的一个元素.不用说,Session首先为我们解决Web无状态的难题,
#这个工作主要由restful-authentication做了.第二,我们可以用session来承载所有通过授权的用户.
#这个非常重要,正如前面提到的那样,在RBAC授权模型中,User仅仅是纯粹的用户,权限已被剥离掉. 
#User是不能与Privilege 直接关联,User 要拥有对某种资源进行操作,必须通过Role去关联.如果用户注册了,
#我们可以分配他一个叫user(注册用户)或wikier(维客)这样的角色,但如果他没有注册或没有登录,岂不是在重重关
#卡的网站中寸步难行,一个网站总有一些公开资源吧,这岂不是与我们的初衷相悖.因此我们要求尽管用户没有登录也要给
#他一个角色,这个工作由declarative_authorization负责.