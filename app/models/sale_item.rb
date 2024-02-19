# frozen_string_literal: true

# == Schema Information
#
# Table name: sale_items
#
#  id         :bigint           not null, primary key
#  quantity   :integer
#  unit_price :decimal(, )
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :bigint           not null
#  sale_id    :bigint           not null
#
class SaleItem < ApplicationRecord
  belongs_to :sale, required: true
  belongs_to :product, required: true
  include PgSearch::Model
  has_paper_trail

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
end