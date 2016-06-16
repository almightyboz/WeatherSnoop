describe "Searching an address", type: :feature do

  it "returns a forecast page when searched" do
    visit root_path
    fill_in "address-input", with: "534 Washington Ave Newtown PA"
    click_button 'Search'
    expect(page). to have_content "Forecast"
    expect(page).to have_selector 'div#temperature'
    expect(page).to have_selector 'div#wind-speed'
    expect(page).to have_selector 'div#precip'
  end

  it "redirects to a page with weather infographics" do
    visit root_path
    fill_in "address-input", with: "534 Washington Ave Newtown PA"
    click_button 'Search'
    expect(page).to have_selector 'div#temperature'
    expect(page).to have_selector 'div#wind-speed'
    expect(page).to have_selector 'div#precip'
  end


end