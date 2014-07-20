class UserError < StandardError
  def initialize(msg = "UserError: invalid input from user")
    super
  end
end