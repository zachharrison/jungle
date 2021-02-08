require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'Validations' do
    it 'should create a user and save if all fields are valid' do 
      @user = User.create(
        name: "Joe Smith",
        email: "joesmith@gmail.com",
        password: 'password',
        password_confirmation: 'password'
      )
      expect(@user).to be_valid
    end
  end

end
