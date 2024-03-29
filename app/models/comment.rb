# frozen_string_literal: true

# == Schema Information
#
# Table name: comments
#
#  id                :bigint           not null, primary key
#  commenteable_type :string
#  text              :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  commenteable_id   :integer
#  user_id           :bigint
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

  def as_json(_options = nil)
    {
      id:,
      commenteable_id:,
      commenteable_type:,
      text:,
      created_at:,
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
