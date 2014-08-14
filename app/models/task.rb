class Task < ActiveRecord::Base
  belongs_to :task_list
  before_save :present?

  validates :description,:assigned_to,:due_date, presence: true

  # validates :assigned_to, presence: true

  def present?
    (due_date - Date.today) >= 0
  end

end