# frozen_string_literal: true

# == Schema Information
#
# Table name: sales
#
#  id         :bigint           not null, primary key
#  date       :datetime
#  total      :decimal(, )
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  client_id  :bigint
#  user_id    :bigint           not null
#
class Sale < ApplicationRecord
  belongs_to :user, required: true
  belongs_to :client, required: false
  has_many :sale_items
  has_many :products, through: :sale_items
  include PgSearch::Model
  has_paper_trail

  after_commit :update_product_quantities

  def to_s
    super
  end

  def self.search(search, page)
    if search.present?
      paginate(per_page: 20, page:).full_search(search)
    else
      paginate(per_page: 20, page:)
    end
  end

  pg_search_scope(
    :full_search,
    against: %i[],
    associated_against: {}, # relation: %i[f1, f2], another: %i[f1, f2]
    using: { tsearch: { prefix: true } },
    ignoring: :accents
  )

  def update_total
    total_amount = sale_items.sum(&:total)
    update(total: total_amount)
  end

  private

  def update_product_quantities    
    sale_items.each do |sale_item|
      product = Product.find(sale_item.product_id)
      new_quantity = product.quantity - sale_item.quantity
      product.update(quantity: new_quantity)
    end
  end
  
end
