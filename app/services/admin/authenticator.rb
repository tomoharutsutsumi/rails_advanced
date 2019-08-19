class Admin::Authenticator
  def initialize(admin_member)
    @admin_member = admin_member
  end

  def authenticator(raw_password)
    @admin_member &&
    !@admin_member.suspended? &&
    @admin_member.hashed_password &&
    BCrypt::Password.new(@admin_member.hashed_password) == raw_password
  end
end