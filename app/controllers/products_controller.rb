# frozen_string_literal: true

# ProductsController
class ProductsController < ApplicationController
  load_and_authorize_resource

  # GET /products
  # GET /products.json
  def index
    @q = @products.ransack(params[:q])
    @q.sorts = 'id desc' if @q.sorts.empty?
    @products = @q.result
    @products = @products.order(:id).search(params[:pgq], params[:page])
    return unless params[:select2]

    select2_render
  end

  # GET /products/1
  # GET /products/1.json
  def show; end

  # GET /products/new
  def new; end

  # GET /products/1/edit
  def edit; end

  # POST /products
  # POST /products.json
  def create
    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: "#{t('activerecord.models.product.one')} criado com sucesso" }
        format.json { render action: 'show', status: :created, location: @product }
      else
        format.html { render action: 'new' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: "#{t('activerecord.models.product.one')} atualizado com sucesso." }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def product_params
    sanitize_active_storage_params(Product, @product)
    params.require(:product).permit(:sku, :name, :description, :quantity, :category_id, :resale_price, :supplier_id, :cost, :image, :brand_id)
  end

  def select2_render
    render json: Oj.dump(
      {
        results: @products.map { |product| { text: product.to_s, id: product.id } },
        pagination: { more: @products.next_page.present? }
      }, mode: :compat
    )
  end
end
