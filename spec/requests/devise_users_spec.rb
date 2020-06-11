require 'rails_helper'

RSpec.describe "UserAuthentications", type: :request do
  let(:user) { create(:user) }
  let(:user_params) { attributes_for(:user) }
  let(:invalid_user_params) { attributes_for(:user, username: "") }

  describe 'Signup' do
    context 'when valid parameters' do
      it 'success request' do
        post user_registration_path, params: { user: user_params }
        expect(response.status).to eq 302
      end

      it 'create successfully' do
        expect do
          post user_registration_path, params: { user: user_params }
        end.to change(User, :count).by 1
      end

      it 'redirect' do
        post user_registration_path, params: { user: user_params }
        expect(response).to redirect_to user_path(id: 1)
      end
    end

    context 'when invalid parameters' do
      it 'success request' do
        post user_registration_path, params: { user: invalid_user_params }
        expect(response.status).to eq 200
      end

      it 'failed to create' do
        expect do
          post user_registration_path, params: { user: invalid_user_params }
        end.to_not change(User, :count)
      end

      it 'error appeared' do
        post user_registration_path, params: { user: invalid_user_params }
        expect(response.body).to include 'prohibited this user from being saved'
      end
    end
  end
end