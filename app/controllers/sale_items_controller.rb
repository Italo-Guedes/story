# frozen_string_literal: true

# SaleItemsController
class SaleItemsController < ApplicationController
  load_and_authorize_resource

  # GET /sale_items
  # GET /sale_items.json
  def index
    @q = @sale_items.ransack(params[:q])
    @q.sorts = 'id desc' if @q.sorts.empty?
    @sale_items = @q.result
    @sale_items = @sale_items.order(:id).search(params[:pgq], params[:page])
    return unless params[:select2]

    select2_render
  end

  # GET /sale_items/1
  # GET /sale_items/1.json
  def show; end

  # GET /sale_items/new
  def new; end

  # GET /sale_items/1/edit
  def edit; end

  # POST /sale_items
  # POST /sale_items.json
  def create
    respond_to do |format|
      if @sale_item.save
        format.html { redirect_to @sale_item, notice: "#{t('activerecord.models.sale_item.one')} criado com sucesso" }
        format.json { render action: 'show', status: :created, location: @sale_item }
      else
        format.html { render action: 'new' }
        format.json { render json: @sale_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sale_items/1
  # PATCH/PUT /sale_items/1.json
  def update
    respond_to do |format|
      if @sale_item.update(sale_item_params)
        format.html { redirect_to @sale_item, notice: "#{t('activerecord.models.sale_item.one')} atualizado com sucesso." }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @sale_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sale_items/1
  # DELETE /sale_items/1.json
  def destroy
    @sale_item.destroy
    respond_to do |format|
      format.html { redirect_to sale_items_url }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def sale_item_params
    sanitize_active_storage_params(SaleItem, @sale_item)
    params.require(:sale_item).permit(:sale_id, :product_id, :quantity, :unit_price)
  end

  def select2_render
    render json: Oj.dump(
      {
        results: @sale_items.map { |sale_item| { text: sale_item.to_s, id: sale_item.id } },
        pagination: { more: @sale_items.next_page.present? }
      }, mode: :compat
    )
  end
end
