# == Schema Information
#
# Table name: post_subs
#
#  id      :integer          not null, primary key
#  sub_id  :integer          not null
#  post_id :integer          not null
#

class PostSub < ActiveRecord::Base
  validates :post, :sub, presence: true
  # validates :post_id, uniqueness: {scope: :sub_id}

  belongs_to :post,
    class_name: :Post,
    foreign_key: :post_id,
    inverse_of: :post_subs

  belongs_to :sub,
    class_name: :Sub,
    foreign_key: :sub_id,
    inverse_of: :post_subs

end
