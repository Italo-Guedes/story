# frozen_string_literal: true

# StocksController
class StocksController < ApplicationController
  load_and_authorize_resource

  # GET /stocks
  # GET /stocks.json
  def index
    @q = @stocks.ransack(params[:q])
    @q.sorts = 'id desc' if @q.sorts.empty?
    @stocks = @q.result
    @stocks = @stocks.order(:id).search(params[:pgq], params[:page])
    return unless params[:select2]

    select2_render
  end

  # GET /stocks/1
  # GET /stocks/1.json
  def show; end

  # GET /stocks/new
  def new; end

  # GET /stocks/1/edit
  def edit; end

  # POST /stocks
  # POST /stocks.json
  def create
    respond_to do |format|
      if @stock.save
        format.html { redirect_to @stock, notice: "#{t('activerecord.models.stock.one')} criado com sucesso" }
        format.json { render action: 'show', status: :created, location: @stock }
      else
        format.html { render action: 'new' }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stocks/1
  # PATCH/PUT /stocks/1.json
  def update
    respond_to do |format|
      if @stock.update(stock_params)
        format.html { redirect_to @stock, notice: "#{t('activerecord.models.stock.one')} atualizado com sucesso." }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stocks/1
  # DELETE /stocks/1.json
  def destroy
    @stock.destroy
    respond_to do |format|
      format.html { redirect_to stocks_url }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def stock_params
    sanitize_active_storage_params(Stock, @stock)
    params.require(:stock).permit(:quantity, :product_id)
  end

  def select2_render
    render json: Oj.dump(
      {
        results: @stocks.map { |stock| { text: stock.to_s, id: stock.id } },
        pagination: { more: @stocks.next_page.present? }
      }, mode: :compat
    )
  end
end
