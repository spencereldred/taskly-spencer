class Task < ActiveRecord::Base
  belongs_to :task_list
  before_save :present?

  validates :description, presence: true

  def present?
    (due_date - Date.today) >= 0
  end

end