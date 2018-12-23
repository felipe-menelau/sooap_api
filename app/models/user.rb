class User
  include Mongoid::Document
  include BCrypt

  field :name, type: String
  field :email, type: String
  field :password_digest, type: String

  validates_presence_of :name, :email, :password

  def password
    @password ||= Password.new(password_digest)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_digest = @password
  end
end
