# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  content    :text             not null
#  user_id    :integer
#  post_id    :integer
#  parent_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ActiveRecord::Base

  belongs_to :author, class_name: 'User', foreign_key: :user_id, primary_key: :id
  belongs_to :post
  belongs_to :parent, class_name: 'Comment', foreign_key: :parent_id, primary_key: :id
  has_many :children, class_name: 'Comment', foreign_key: :parent_id, primary_key: :id
end
