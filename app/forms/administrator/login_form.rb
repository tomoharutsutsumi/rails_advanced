class Administrator::LoginForm
  include ActiveModel::Model

  attr_accessor :email, :password
end