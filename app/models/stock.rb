# frozen_string_literal: true

# == Schema Information
#
# Table name: stocks
#
#  id         :bigint           not null, primary key
#  quantity   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :bigint           not null
#
class Stock < ApplicationRecord
  belongs_to :product, required: true
  include PgSearch::Model
  has_paper_trail

  after_save :update_product
  

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

  private

  # def update_product
  #   product = Product.find_by(id: product_id)
  #   product.quantity = quantity
  #   return unless product

  #   product.update(quantity: quantity)
  # end
  def update_product
    product = Product.find_by(id: product_id)
      return unless product

      product.update_column(:quantity, quantity)
  end

end