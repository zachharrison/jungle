require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'Validations' do
    it 'should create a user and save if all fields are valid' do 
      @user = User.create(
        first_name: "John",
        last_name: "Doe",
        email: "jdoe@gmail.com",
        password: 'password',
        password_confirmation: 'password'
      )
      expect(@user).to be_valid
    end

    it 'should fail to save user without matching password confirmations' do
      @user = User.create(
        first_name: "John",
        last_name: "Doe",
        email: "jdoe@gmail.com",
        password: "password",
        password_confirmation: "passwor"
      )
      expect(@user).to_not be_valid
    end

    it 'should fail to save user when email is already taken' do
      @user = User.create(
        first_name: "John",
        last_name: "Doe",
        email: "jdoe@gmail.com",
        password: "password",
        password_confirmation: "password"
      )
      @user2 = User.create(
        first_name: "John Jr",
        last_name: "Doe",
        email: "JDOE@gmail.com",
        password: "password",
        password_confirmation: "password"
      )
      expect(@user2).to_not be_valid
    end

    it 'should fail to save user without first name' do
      @user = User.create(
        first_name: nil,
        last_name: "Doe",
        email: "jdoe@gmail.com",
        password: "password",
        password_confirmation: "password"
      )
      expect(@user.errors.full_messages).to include "First name can't be blank"
    end

    it 'should fail to save user without last name' do
      @user = User.create(
        first_name: "John",
        last_name: nil,
        email: "jdoe@gmail.com",
        password: "password",
        password_confirmation: "password"
      )
      expect(@user.errors.full_messages).to include "Last name can't be blank"
    end

    it 'should fail to save user without email' do
      @user = User.create(
        first_name: "John",
        last_name: "Doe",
        email: nil,
        password: "password",
        password_confirmation: "password"
      )
      expect(@user.errors.full_messages).to include "Email can't be blank"
    end

    it 'should fail to save user when password is less than 5 characters long' do 
      @user = User.create(
        first_name: "John",
        last_name: "Doe",
        email: "jdoe@gmail.com",
        password: '123',
        password_confirmation: '123'
      )
      expect(@user.errors.full_messages).to include "Password is too short (minimum is 5 characters)"
    end
  end

  describe '.authenticate_with_credentials' do

    it 'should login a valid user' do
      @user = User.create(
        last_name: "John",
        first_name: "Doe",
        email: "jdoe@gmail.com",
        password: "password",
        password_confirmation: "password"
      )
      @john = User.authenticate_with_credentials(@user.email, @user.password)
      expect(@john.id).to be @user.id
    end

    it "should login in user with capital letters in email" do
      @user = User.create(
        last_name: "John",
        first_name: "Doe",
        email: "jdoe@gmail.com",
        password: "password",
        password_confirmation: "password"
      )
      @john = User.authenticate_with_credentials("JDOE@GMAIL.COM", @user.password)
      expect(@john.id).to be @user.id
    end

    it "should login in user with spaces in email" do
      @user = User.create(
        last_name: "John",
        first_name: "Doe",
        email: "jdoe@gmail.com",
        password: "password",
        password_confirmation: "password"
      )
      @john = User.authenticate_with_credentials("   jdoe@gmail.com   ", @user.password)
      expect(@john.id).to be @user.id
    end
  end

end
