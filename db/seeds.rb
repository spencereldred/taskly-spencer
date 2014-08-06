User.destroy_all
TaskList.destroy_all

User.create!(
  name: "Some User",
  email: 'user@example.com',
  password: 'password',
  password_confirmation: 'password'
)

TaskList.create!(name: "Work List")
TaskList.create!(name: "Household Chores")

Task.create!(description: "go to work", due_date: Date.today, task_list_id: 1)
