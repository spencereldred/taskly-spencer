require 'rails_helper'

describe TaskList do
  before { @task_list = TaskList.create(name: "My Task List") }

  subject { @task_list }


  it "should be valid" do
    # task_list = TaskList.create(name: "My Task List")
    expect(@task_list).to be_valid
  end

  it "empty task list field not be valid" do
    task_list = TaskList.create(name: "")
    expect(task_list).to_not be_valid
  end

  it "more than 20 characters should not be valid" do
    task_list = TaskList.create(name: "task" * 6)
    expect(task_list).to_not be_valid
  end

end