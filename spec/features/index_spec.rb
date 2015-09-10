require 'spec_helper'

feature "meetups in space index", %(
  As a User I want to see a a list of meetups available,
  and be able to submit new meetups, and delete meetups.
) do
  scenario "when user visit this page, its the right page" do
    visit "/"

    expect(page).to have_content("Meetups in Space")

  end

  scenario "user can submmit a meetup" do
    visit "/"

    fill_in "title", with: "Grass?"
    fill_in "description", with: "Lets talk about grass in space!"
    fill_in "location", with: "Fields of mercury"
    click_on "Submit"

    expect(page).to have_content("Grass?")
    expect(page).to have_content("Lets talk about grass in space!")
    expect(page).to have_content("Fields of mercury")
  end

  scenario "user can delete a meetup" do
    visit "/"

    fill_in "title", with: "Grass?"
    fill_in "description", with: "Lets talk about grass in space!"
    fill_in "location", with: "Fields of mercury"
    click_on "Submit"

    expect(page).to have_content("Grass?")
    expect(page).to have_content("Lets talk about grass in space!")
    expect(page).to have_content("Fields of mercury")
    click_on "Go back"
    click_on "delete"

    expect(page).to_not have_content("Grass?")
    expect(page).to_not have_content("Lets talk about grass in space!")
    expect(page).to_not have_content("Fields of mercury")

  end

end
