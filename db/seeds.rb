User.destroy_all
TaskList.destroy_all

User.create!(
  name: "First User",
  email: 'user@example.com',
  password: 'password',
  password_confirmation: 'password'
)
User.create!(
  name: "Second User",
  email: 'user2@example.com',
  password: 'password',
  password_confirmation: 'password'
)
TaskList.create!(name: "Work List")
TaskList.create!(name: "Household Chores")

Task.create!(description: "go to work", due_date: Date.new(2014, 11, 4), task_list_id: 1, assigned_to: "First User")
Task.create!(description: "do some work", due_date: Date.new(2014, 10, 13), task_list_id: 1, assigned_to: "Second User")
Task.create!(description: "Wash the floor", due_date: Date.new(2014, 10, 13), task_list_id: 2, assigned_to: "Second User")
