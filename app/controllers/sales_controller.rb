# frozen_string_literal: true

# SalesController
class SalesController < ApplicationController
  load_and_authorize_resource

  # GET /sales
  # GET /sales.json
  def index
    @q = @sales.ransack(params[:q])
    @q.sorts = 'id desc' if @q.sorts.empty?
    @sales = @q.result
    @sales = @sales.order(:id).search(params[:pgq], params[:page])
    return unless params[:select2]

    select2_render
  end

  # GET /sales/1
  # GET /sales/1.json
  def show; end

  # GET /sales/new
  def new; end

  # GET /sales/1/edit
  def edit; end

  # POST /sales
  # POST /sales.json
  def create
    respond_to do |format|
      if @sale.save
        format.html { redirect_to @sale, notice: "#{t('activerecord.models.sale.one')} criado com sucesso" }
        format.json { render action: 'show', status: :created, location: @sale }
      else
        format.html { render action: 'new' }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sales/1
  # PATCH/PUT /sales/1.json
  def update
    respond_to do |format|
      if @sale.update(sale_params)
        format.html { redirect_to @sale, notice: "#{t('activerecord.models.sale.one')} atualizado com sucesso." }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sales/1
  # DELETE /sales/1.json
  def destroy
    @sale.destroy
    respond_to do |format|
      format.html { redirect_to sales_url }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def sale_params
    sanitize_active_storage_params(Sale, @sale)
    params.require(:sale).permit(:date, :total, :user_id, :client_id)
  end

  def select2_render
    render json: Oj.dump(
      {
        results: @sales.map { |sale| { text: sale.to_s, id: sale.id } },
        pagination: { more: @sales.next_page.present? }
      }, mode: :compat
    )
  end
end
