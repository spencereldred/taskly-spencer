require 'rails_helper'
require 'capybara/rails'

feature 'Task lists' do

  before do
    # Freeze today to 10/1/2014, calculate date from there
    Timecop.freeze(Date.new(2014, 10, 01))

    # create user, task_lists, login
    create_user email: "user@example.com"
    TaskList.create!(name: "Household Chores")
    TaskList.create!(name: "Work List")
    visit signin_path
    click_on "Login"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"
  end

  after do
    # release the Timecop
    Timecop.return
  end

  scenario 'User can view task lists' do
    # save_and_open_page
    expect(page).to have_content("Work List")
    expect(page).to have_content("Household Chores")
    # with no tasks - special message appears
    expect(page).to have_content("Nothing here to see!")
  end

  scenario "As an anonamous user, I can visit the abouts page" do
    visit signin_path
    expect(page).to have_content("About")
    click_on "About"
    expect(page).to have_content("Lorem ipsum dolor sit amet,")
  end

  scenario 'As a signed in user, I can create a new task list' do
    expect(page).to have_content("+ Add Task List")
    # Initial task list displayed
    expect(page).to have_content("Work List")

    # Add a task list
    click_on "+ Add Task List"
    expect(page).to have_content("Add a Task List")
    fill_in "task_list[name]", with: "Grocery List"
    click_on "Create Task List"
    expect(page).to have_content("Task List was created successfully!")
    expect(page).to have_content("Grocery List")

    # Add a Task_list with no name - error message
    click_on "+ Add Task List"
    expect(page).to have_content("Add a Task List")
    click_on "Create Task List"
    expect(page).to have_content("Your task could not be created.")
  end

  scenario 'As a signed in user, I can edit a task list' do
    expect(page).to have_content("+ Add Task List")
    expect(page).to have_content("Work List")

    within(first(".task-list")) do
      click_on "Edit"
    end

    expect(page).to have_content("Edit a Task List")
    # expect(page).to have_content("Household Chores")
    fill_in "Name", with: "Household Chores and More"
    click_on "Update Task List"
    expect(page).to have_content("Household Chores and More")
    expect(page).to have_content("Task List was updated successfully!")
  end

  scenario "As a user, I can add a task with proper due date and delete it" do
    expect(page).to have_content("+ Add Task List")
    expect(page).to have_content("Work List")
    expect(page).to have_content("Household Chores")
    expect(page).to have_content("+ Add New Task")

    within(first(".task-list")) do
      click_on "+ Add New Task"
    end

    expect(page).to have_content("Add a task")

    fill_in "Description", with: "Feed the cats"

    select "2014", from: "task[due_date(1i)]"
    select "November", from: "task[due_date(2i)]"
    select "4", from: "task[due_date(3i)]"
    click_on "Create Task"
    expect(page).to have_content("Task was created successfully!")
    expect(page).to have_content("Feed the cats (35 days)")

    # delete the task
    within(first("div.tasks")) do
      within("div") do
        click_on "Delete"
      end
    end

    expect(page).to have_content("Task was deleted successfully!")
    expect(page).not_to have_content("Feed the cats")

    # Add another task
    within(first(".task-list")) do
      click_on "+ Add New Task"
    end

    expect(page).to have_content("Add a task")

    fill_in "Description", with: "Walk the dog"
    click_on "Create Task"
    expect(page).to have_content("Task was created successfully!")
    expect(page).to have_content("Walk the dog")

    # Click on List name to see open tasks - i.e. not completed
    click_on "Household Chores"
    expect(page).to have_content("Household Chores")
    expect(page).not_to have_content("Work List")
    expect(page).to have_content("Walk the dog")

  end

  scenario "As a user, completed tasks do not appear on list" do
    expect(page).to have_content("+ Add Task List")
    expect(page).to have_content("Work List")
    expect(page).to have_content("+ Add New Task")

    # create first task
    within(first(".task-list")) do
      click_on "+ Add New Task"
    end

    expect(page).to have_content("Add a task")
    fill_in "Description", with: "Feed the cats"
    select "2014", from: "task[due_date(1i)]"
    select "November", from: "task[due_date(2i)]"
    select "4", from: "task[due_date(3i)]"
    click_on "Create Task"
    expect(page).to have_content("Task was created successfully!")
    expect(page).to have_content("Feed the cats (35 days)")

    # create second task
    within(first(".task-list")) do
      click_on "+ Add New Task"
    end
    expect(page).to have_content("Add a task")
    fill_in "Description", with: "Jump the Shark"
    select "2014", from: "task[due_date(1i)]"
    select "October", from: "task[due_date(2i)]"
    select "4", from: "task[due_date(3i)]"
    click_on "Create Task"
    expect(page).to have_content("Task was created successfully!")
    expect(page).to have_content("Jump the Shark (4 days)")

    # create third task
    within(first(".task-list")) do
      click_on "+ Add New Task"
    end
    expect(page).to have_content("Add a task")
    fill_in "Description", with: "Walk the dog"
    select "2014", from: "task[due_date(1i)]"
    select "October", from: "task[due_date(2i)]"
    select "13", from: "task[due_date(3i)]"
    click_on "Create Task"
    expect(page).to have_content("Task was created successfully!")
    expect(page).to have_content("Walk the dog (13 days)")

    # mark the first task completed
    # sorted by due date: first task should be "Jump the Shark (4 days)"
    within(first("div.tasks")) do
      within("div") do
        click_on "Completed"
      end
    end

    # view completed task page, should not have uncompleted tasks
    expect(page).to have_content("Household Chores - Completed")
    expect(page).to have_content("Jump the Shark (4 days)")
    expect(page).not_to have_content("Feed the cats (35 days)")
    expect(page).not_to have_content("Walk the dog (13 days)")

    # index page should not show completed tasks
    visit root_path
    expect(page).not_to have_content("Jump the Shark (4 days)")
  end

  scenario "As a user, I should be able to delete a task list" do
    expect(page).to have_content("Household Chores")
    expect(page).to have_content("Work List")
    within(first(".task-list")) do
      click_on "Delete"
    end
    expect(page).not_to have_content("Household Chores")
    expect(page).to have_content("Work List")
  end

  scenario "As a user, I should be able to assign a user as I create a task" do
    # create first task
    within(first(".task-list")) do
      click_on "+ Add New Task"
    end

    expect(page).to have_content("Add a task")
    expect(page).to have_content("Description")
    expect(page).to have_content("Due Date")
    expect(page).to have_content("Assigned to")
    fill_in "Description", with: "Feed the cats"
    select "2014", from: "task[due_date(1i)]"
    select "November", from: "task[due_date(2i)]"
    select "4", from: "task[due_date(3i)]"
    save_and_open_page
    select 'Some User', from: "task[assigned_to]"
    click_on "Create Task"
    expect(page).to have_content("Task was created successfully!")
    # save_and_open_page
    expect(page).to have_content("Feed the cats (35 days) - Some User")

  end



end