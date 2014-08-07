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

    # Task_list entered correctly
    click_on "+ Add Task List"
    expect(page).to have_content("Add a Task List")
    fill_in "task_list[name]", with: "Grocery List"
    click_on "Create Task List"
    expect(page).to have_content("Task List was created successfully!")
    expect(page).to have_content("Grocery List")

    # Task_list left blank - error message
    click_on "+ Add Task List"
    expect(page).to have_content("Add a Task List")
    click_on "Create Task List"
    expect(page).to have_content("Your task could not be created.")
  end

  scenario 'As a signed in user, I can edit a task list' do
    create_user email: "user@example.com"
    TaskList.create!(name: "Work List")

    visit signin_path
    click_on "Login"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"
    expect(page).to have_content("+ Add Task List")
    expect(page).to have_content("Work List")

    click_on "Edit"
    expect(page).to have_content("Edit a Task List")
    fill_in "Name", with: "Work More List"
    click_on "Update Task List"
    expect(page).to have_content("Work More List")
    expect(page).to have_content("Task List was updated successfully!")
  end

  scenario "As a user, I can add a task" do
    create_user email: "user@example.com"
    TaskList.create!(name: "Work List")
    TaskList.create!(name: "Household Chores")

    visit signin_path
    click_on "Login"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"
    expect(page).to have_content("+ Add Task List")
    expect(page).to have_content("Work List")
    expect(page).to have_content("Household Chores")
    expect(page).to have_content("+ Add New Task")

    # save_and_open_page

    within(first(".task-list")) do
      click_on "+ Add New Task"
    end

    expect(page).to have_content("Add a task")

    fill_in "Description", with: "Feed the cats"
    click_on "Create Task"
    expect(page).to have_content("Task was created successfully!")
    expect(page).to have_content("Feed the cats")

    within("div.tasks") do
      within("div") do
        click_on "Delete"
      end
    end

    expect(page).to have_content("Task was deleted successfully!")
    expect(page).not_to have_content("Feed the cats")

    # save_and_open_page

    within(first(".task-list")) do
      click_on "+ Add New Task"
    end

    expect(page).to have_content("Add a task")

    fill_in "Description", with: "Walk the dog"
    click_on "Create Task"
    expect(page).to have_content("Task was created successfully!")
    expect(page).to have_content("Walk the dog")


    click_on "Household Chores"
    expect(page).to have_content("Household Chores")
    expect(page).not_to have_content("Work List")
    # save_and_open_page
    expect(page).to have_content("Walk the dog")

  end

  scenario "As a user, completed tasks do not appear on list" do
    create_user email: "user@example.com"
    TaskList.create!(name: "Work List")

    visit signin_path
    click_on "Login"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"
    expect(page).to have_content("+ Add Task List")
    expect(page).to have_content("Work List")
    expect(page).to have_content("+ Add New Task")
    # save_and_open_page

    within(first(".task-list")) do
      click_on "+ Add New Task"
    end

    expect(page).to have_content("Add a task")

    fill_in "Description", with: "Feed the cats"
    click_on "Create Task"
    expect(page).to have_content("Task was created successfully!")
    expect(page).to have_content("Feed the cats")

    within("div.tasks") do
      within("div") do
        click_on "Completed"
      end
    end

    # expect(page).to have_content("Work List - Completed")
    # expect(page).to have_content("Feed the cats")
    expect(page).not_to have_content("Feed the cats")

  end


end