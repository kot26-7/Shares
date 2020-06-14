require 'rails_helper'

RSpec.describe "Posts", type: :request do

  describe "GET /posts#index" do
    it "returns http success" do
      get posts_path
      expect(response).to have_http_status(:success)
    end
  end

end
