class User
  include Mongoid::Document
  has_secure_password
  field :name, type: String
  field :email, type: String
  field :password_digest, type: String
end
