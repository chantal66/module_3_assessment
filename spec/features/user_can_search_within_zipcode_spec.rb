require 'rails_helper'
# As a user
# When I visit "/"
# And I fill in a search box with "80202" and click "search"
# Then my current path should be "/search" (ignoring params)
# And I should see stores within 25 miles of 80202
# And I should see a message that says "17 Total Stores"
# And I should see exactly 10 results (There are 17 stores within 25 miles. We want to display 10 on this page and 7 on the next. Get the first page to work first from start to finish and worry about pagination later.)
# And I should see the long name, city, distance, phone number and store type for each of the 10 results```

RSpec.feature 'user can search for a store in zipcode' do
  it 'should see first 10 stores within 25 miles' do

    visit root_path

    fill_in "Find Stores near your ZIP", with: "80202"

    click_button "Search"

    expect(current_path).to eq search_path
    expect(stores.count).to eq(10)
    expect(page).to have_content('17 Stores within 25 miles')
    expect(page).to have_content '10 Stores'
    expect(stores.first).to have_content "Name:"
    expect(stores.first).to have_content "City:"
    expect(stores.first).to have_content "Distance:"
    expect(stores.first).to have_content "Phone Number:"
    expect(stores.first).to have_content "Store Type:"
    expect(page).to have_link "Next Page", search_path
  end
end