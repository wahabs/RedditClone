class Post < ActiveRecord::Base
  validates :title, presence: true
  # belongs_to :sub
  belongs_to(:author, class_name: "User", foreign_key: :user_id, primary_key: :id)
  has_many :subs, through: :post_subs
  has_many :post_subs
  has_many :comments, dependent: :destroy

  def author_email
    author.email
  end

end
