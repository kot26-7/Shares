require 'rails_helper'

RSpec.describe User, type: :model do
  it 'valid user' do
    expect(build(:user)).to be_valid
  end

  it 'invalid without username' do
    user = build(:user, username: "")
    expect(user).to_not be_valid
  end

  it 'invalid without fullname' do
    user = build(:user, fullname: "")
    expect(user).to_not be_valid
  end

  it 'invalid without email' do
    user = build(:user, email: "")
    expect(user).to_not be_valid
  end

  it 'invalid without password' do
    user = build(:user, password: "")
    expect(user).to_not be_valid
  end
end
