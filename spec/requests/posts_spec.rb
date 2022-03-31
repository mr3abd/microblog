require "rails_helper"

RSpec.describe "Posts", type: :request do
  describe "GET /" do
    it "renders successfully" do
      get root_url

      expect(response).to be_successful
    end
  end
end
