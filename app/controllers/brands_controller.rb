# frozen_string_literal: true

# BrandsController
class BrandsController < ApplicationController
  load_and_authorize_resource

  # GET /brands
  # GET /brands.json
  def index
    @q = @brands.ransack(params[:q])
    @q.sorts = 'id desc' if @q.sorts.empty?
    @brands = @q.result
    @brands = @brands.order(:id).search(params[:pgq], params[:page])
    return unless params[:select2]

    select2_render
  end

  # GET /brands/1
  # GET /brands/1.json
  def show; end

  # GET /brands/new
  def new; end

  # GET /brands/1/edit
  def edit; end

  # POST /brands
  # POST /brands.json
  def create
    respond_to do |format|
      if @brand.save
        format.html { redirect_to @brand, notice: "#{t('activerecord.models.brand.one')} criado com sucesso" }
        format.json { render action: 'show', status: :created, location: @brand }
      else
        format.html { render action: 'new' }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /brands/1
  # PATCH/PUT /brands/1.json
  def update
    respond_to do |format|
      if @brand.update(brand_params)
        format.html { redirect_to @brand, notice: "#{t('activerecord.models.brand.one')} atualizado com sucesso." }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /brands/1
  # DELETE /brands/1.json
  def destroy
    @brand.destroy
    respond_to do |format|
      format.html { redirect_to brands_url }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def brand_params
    sanitize_active_storage_params(Brand, @brand)
    params.require(:brand).permit(:name)
  end

  def select2_render
    render json: Oj.dump(
      {
        results: @brands.map { |brand| { text: brand.to_s, id: brand.id } },
        pagination: { more: @brands.next_page.present? }
      }, mode: :compat
    )
  end
end
