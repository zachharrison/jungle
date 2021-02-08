require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    
    it "will create a category and save to database" do
      @category = Category.create(name: "Shoes")
      @product = Product.create(name: "Air Jordan 1", price: 100000, quantity: 1, category: @category)
      expect(@product).to be_present
    end

    it "does not save if product name is missing" do
      @category = Category.create(name: "Shoes")
      @product = Product.create(name: nil, price: 100000, quantity: 1, category: @category)
      expect(@product.errors.full_messages).to include "Name can't be blank"
    end

    it "does not save if product price is missing" do
      @category = Category.create(name: "Shoes")
      @product = Product.create(name: "Air Jordan 1", price: nil, quantity: 1, category: @category)
      expect(@product.errors.full_messages).to include "Price can't be blank"
    end

    it "does not save if product quantity is missing" do
      @category = Category.create(name: "Shoes")
      @product = Product.create(name: "Air Jordan 1", price: 100000, quantity: nil, category: @category)
      expect(@product.errors.full_messages).to include "Quantity can't be blank"
    end

    it "does not save if product category is missing" do
      @product = Product.create(name: "Air Jordan 1", price: 100000, quantity: 1, category: nil)
      expect(@product.errors.full_messages).to include "Category can't be blank"
    end

  end
end
