require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }

  describe "GET /users-access" do
    context 'before-login' do
      it "accsess to users index" do
        get users_path
        expect(response).to have_http_status 200
      end

      it "accsess to login page" do
        get new_user_session_path
        expect(response).to have_http_status 200
      end

      it "accsess to signup page" do
        get new_user_registration_path
        expect(response).to have_http_status 200
      end

      it "user-show" do
        get user_path(id: 1)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'after-login' do
      before do
        sign_in user
      end

      it 'accsess to user-show' do
        get user_path(id: user.id)
        expect(response).to have_http_status 200
      end

    end
  end
end
