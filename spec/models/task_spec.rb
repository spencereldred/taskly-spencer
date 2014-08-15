require 'rails_helper'

describe Task do

  it "should be valid" do
    date = Date.today + 1
    task = Task.create(description: "Walk the dog", due_date: date, assigned_to: "Some User")
    expect(task).to be_valid
  end

  it "empty task list field not be valid" do
    date = Date.today + 1
    task = Task.create(description: "", due_date: date)
    expect(task).not_to be_valid
  end

end