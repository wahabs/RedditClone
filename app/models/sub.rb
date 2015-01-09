class Sub < ActiveRecord::Base
  validates :title, :description, presence: true
  belongs_to(
    :moderator,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  

end
