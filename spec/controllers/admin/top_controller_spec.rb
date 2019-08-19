require 'rails_helper'

RSpec.describe Admin::TopController, type: :controller do
  let(:administrator) { create(:administrator) }

  before do
    session[:admin_member_id] = administrator.id
    session[:last_access_time] = 1.second.ago
  end

  describe '#index' do
    example '通常はadmin/top/indexを表示' do
      get :index
      expect(response).to render_template('admin/top/dashboard')
    end
    example '停止フラグがセットされたら強制的にログアウト' do
      administrator.update_column(:suspended, true)
      get :index
      expect(session[:admin_member_id]).to be_nil
      expect(response).to redirect_to(admin_root_url)
    end
    example 'セッションタイムアウト' do
      session[:last_access_time] = 
        Admin::Base::TIMEOUT.ago.advance(seconds: -1)
      get :index
      expect(session[:admin_member_id]).to be_nil
      expect(response).to redirect_to(admin_login_url)
    end
  end
end
