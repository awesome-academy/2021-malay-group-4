class Course < ApplicationRecord
  enum status: {Opening: 0, Started: 1, Finished: 2}

  has_many :registers
  has_many :users, through: :registers
end
