class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :description
      t.date :due_date
    end
    add_reference :tasks, :task_list, index: true
  end
end
