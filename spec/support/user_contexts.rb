RSpec.shared_context "with user logged in" do
  def sign_in(user)
    login_as(user, scope: :user)
  end
end
