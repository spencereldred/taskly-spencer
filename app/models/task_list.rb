class TaskList < ActiveRecord::Base
  has_many :tasks, dependent: :destroy

  validates :name, presence: true, length: {maximum: 20}

end