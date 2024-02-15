# frozen_string_literal: true

# CategoriesController
class CategoriesController < ApplicationController
  load_and_authorize_resource

  # GET /categories
  # GET /categories.json
  def index
    @q = @categories.ransack(params[:q])
    @q.sorts = 'id desc' if @q.sorts.empty?
    @categories = @q.result
    @categories = @categories.order(:id).search(params[:pgq], params[:page])
    return unless params[:select2]

    select2_render
  end

  # GET /categories/1
  # GET /categories/1.json
  def show; end

  # GET /categories/new
  def new; end

  # GET /categories/1/edit
  def edit; end

  # POST /categories
  # POST /categories.json
  def create
    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: "#{t('activerecord.models.category.one')} criado com sucesso" }
        format.json { render action: 'show', status: :created, location: @category }
      else
        format.html { render action: 'new' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: "#{t('activerecord.models.category.one')} atualizado com sucesso." }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def category_params
    sanitize_active_storage_params(Category, @category)
    params.require(:category).permit(:name)
  end

  def select2_render
    render json: Oj.dump(
      {
        results: @categories.map { |category| { text: category.to_s, id: category.id } },
        pagination: { more: @categories.next_page.present? }
      }, mode: :compat
    )
  end
end
