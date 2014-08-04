require 'rails_helper'
require 'capybara/rails'

feature 'Task lists' do

  scenario 'User can view task lists' do
    create_user email: "user@example.com"
    TaskList.create!(name: "Work List")
    TaskList.create!(name: "Household Chores")

    visit signin_path
    click_on "Login"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"
    expect(page).to have_content("Work List")
    expect(page).to have_content("Household Chores")
  end

  scenario "As an anonamous user, I can visit the abouts page" do
    visit signin_path
    expect(page).to have_content("About")
    click_on "About"
    expect(page).to have_content("Lorem ipsum dolor sit amet,")
  end

  scenario 'As a signed in user, I can create a new task list' do
    create_user email: "user@example.com"
    TaskList.create!(name: "Work List")

    visit signin_path
    click_on "Login"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"
    expect(page).to have_content("+ Add Task List")
    expect(page).to have_content("Work List")

    click_on "+ Add Task List"
    expect(page).to have_content("Add a Task List")
    fill_in "Name", with: "Grocery List"
    click_on "Create Task List"
    expect(page).to have_content("Task List was created successfully!")
    expect(page).to have_content("Grocery List")
  end


end