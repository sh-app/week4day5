# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  content    :text
#  url        :string
#  sub_id     :integer          not null
#  author_id  :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Post < ActiveRecord::Base
  validates :title, :author_id,  presence: true

  belongs_to(
    :author,
    class_name: 'User',
    foreign_key: :author_id
  )

  has_many :post_subs, inverse_of: :post, dependent: :destroy

  has_many :subs,
    through: :post_subs,
    source: :sub

  has_many :comments,
  class_name: "Comment",
  foreign_key: :post_id

end
