# frozen_string_literal: true

# == Schema Information
#
# Table name: comments
#
#  id                :bigint(8)        not null, primary key
#  commenteable_id   :integer
#  commenteable_type :string
#  user_id           :bigint(8)
#  text              :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

# To add comments to some model:
# Add this to the model:
#   has_many :comments, as: :commenteable
# Add this to routes.rb
#   resources :posts, concerns: :commenteable
# Add this to show.html.erb's end
#   <%= render partial: "comments/index", locals: {:@comments => @post.comments} %>
# TODO: 
#  - ajustar formulário de criar novo comentário
#  - ajustar layouts dos comentários em si

# Comment model
class Comment < ApplicationRecord
  belongs_to :commenteable, polymorphic: true
  belongs_to :user

  after_create :send_notifications
  
  delegate :management_unit, to: :user

  def as_json(options=nil)
    {
      id: id,
      commenteable_id: commenteable_id,
      commenteable_type: commenteable_type,
      text: text,
      created_at: created_at,
      user_id: user.id
    }
  end

  private

  def send_notifications
    # Notification.create(
    #   user: user_owner_of_the_resource, 
    #   text: "Texto", 
    #   link_url: link_of_the_resource, 
    #   image_url: some_image
    # )
  end
end
