# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id           :bigint           not null, primary key
#  cost         :decimal(, )
#  description  :text
#  name         :string
#  quantity     :integer
#  resale_price :decimal(, )
#  sku          :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  brand_id     :bigint           not null
#  category_id  :bigint           not null
#  supplier_id  :bigint           not null
#
class Product < ApplicationRecord
  belongs_to :category, required: true
  belongs_to :supplier, required: true
  belongs_to :brand, required: true
  has_one :stock
  has_many :sale_items
  has_many :sales, through: :sale_items
  has_one_attached :image
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
    against: %i[sku name description],
    associated_against: {}, # relation: %i[f1, f2], another: %i[f1, f2]
    using: { tsearch: { prefix: true } },
    ignoring: :accents
  )
end
