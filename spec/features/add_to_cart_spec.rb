require 'rails_helper'

RSpec.feature "Add to cart", type: :feature do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "Cart updates when product is added" do
    # ACT
    visit root_path

    expect(page).to have_content("My Cart (0)")
    first('article.product').find_button('Add').click
    expect(page).to_not have_content("My Cart (0)")
    expect(page).to have_content("My Cart (1)")
  end
end
