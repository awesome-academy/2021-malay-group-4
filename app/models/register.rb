class Register < ApplicationRecord
  enum status: {Pending: 0, Approved: 1, Denied: 2}

  belongs_to :user
  belongs_to :course

  validates :user_id, uniqueness: {scope: :course_id}
end
