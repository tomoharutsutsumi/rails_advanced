class Admin::SessionsController < Admin::Base
  skip_before_action :authorize
  
  def new
    if current_administrator
      redirect_to :admin_root
    else 
      @form = Administrator::LoginForm.new
    end
  end

  def create 
    @form = Administrator::LoginForm.new(admin_login_form_params)
    if @form.email.present?
      admin_member = Administrator.find_by(email_for_index: @form.email.downcase)
    end
    if admin_member.suspended?
      flash.now.alert = "アカウントが停止されています"
      render action: 'new' and return
    end
    if Admin::Authenticator.new(admin_member).authenticator(@form.password)
      session[:admin_member_id] = admin_member.id
      session[:last_access_time] = Time.current
      flash.notice = "ログインしました"
      redirect_to :admin_root
    else
      flash.now.alert = 'メールアドレスまたはパスワードが正しくありません'
      render action: 'new'
    end
  end

  def destroy
    session.delete(:admin_member_id)
    flash.notice = "ログアウトしました"
    redirect_to :admin_root
  end 

  def admin_login_form_params
    params.require(:administrator_login_form).permit(:email, :password)
  end
end