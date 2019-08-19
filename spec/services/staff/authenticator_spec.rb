require 'rails_helper'

RSpec.describe Admin::Authenticator do
  describe '#authenticate' do
    it '停止フラグが立っておらず、正しいパスワードならtrueを返す' do
      m = FactoryBot.build(:staff_member, suspended: false)
      expect(Staff::Authenticator.new(m).authenticate('pw')).to be_truthy
    end

    it '誤ったパスワードならfalseを返す' do
      m = build(:staff_member)
      expect(Staff::Authenticator.new(m).authenticate('xv')).to be_falsey
    end

    it 'パスワード未設定ならfalseを返す' do
      m = build(:staff_member, password: nil)
      expect(Staff::Authenticator.new(m).authenticate('xv')).to be_falsey
    end

    it '正しいパスワードでも、停止フラグが立っていればfalseを返す' do
      m = build(:staff_member, suspended: true)
      expect(Staff::Authenticator.new(m).authenticate('pw')).to be_falsey
    end

    it '開始前ならfalseを返す' do
      m = build(:staff_member, start_date: Date.tomorrow)
      expect(Staff::Authenticator.new(m).authenticate('pw')).to be_falsey
    end

    it '終了時ならfalseを返す' do
      m = build(:staff_member, end_date: Date.today)
      expect(Staff::Authenticator.new(m).authenticate('pw')).to be_falsey
    end
  end
end