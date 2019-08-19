require 'rails_helper'

RSpec.describe Admin::Authenticator do
  describe '#authenticate' do
    it '停止フラグが立っておらず、正しいパスワードならばtrueを返す' do
      m = build(:administrator)
      expect(Admin::Authenticator.new(m).authenticator('pw')).to be_truthy
    end

    it '誤ったパスワードならfalseを返す' do
      m = build(:administrator)
      expect(Admin::Authenticator.new(m).authenticator('xv')).to be_falsey
    end

    it 'パスワードが未設定ならfalseを返す' do
      m = build(:administrator, password: nil)
      expect(Admin::Authenticator.new(m).authenticator('xv')).to be_falsey
    end

    it '正しいパスワードでも停止フラグが立っていたらfalseになる' do
      m = build(:administrator, suspended: true)
      expect(Admin::Authenticator.new(m).authenticator('pw')).to be_falsey
    end
  end
end