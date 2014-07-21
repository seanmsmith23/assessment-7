require 'spec_helper'

feature 'Homepage' do
  scenario 'Shows welcome message' do
    visit '/'

    expect(page).to have_content("Welcome")
  end

  scenario 'Can add messages' do
    visit '/'

    fill_in "name", with: "Sean"
    fill_in "message", with: "Its me sean!"
    click_button "Add Message"


    expect(page).to have_content("Sean")
    expect(page).to have_content("Its me sean!")
  end

  scenario 'Visitor can see all messages' do
    visit '/'

    fill_in "name", with: "Sean"
    fill_in "message", with: "Its me sean!"
    click_button "Add Message"

    visit '/'

    fill_in "name", with: "Todd"
    fill_in "message", with: "Im Todd!"
    click_button "Add Message"

    expect(page).to have_content("Sean")
    expect(page).to have_content("Its me sean!")
    expect(page).to have_content("Todd")
    expect(page).to have_content("Im Todd!")
  end
end

