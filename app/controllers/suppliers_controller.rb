# frozen_string_literal: true

# SuppliersController
class SuppliersController < ApplicationController
  load_and_authorize_resource

  # GET /suppliers
  # GET /suppliers.json
  def index
    @q = @suppliers.ransack(params[:q])
    @q.sorts = 'id desc' if @q.sorts.empty?
    @suppliers = @q.result
    @suppliers = @suppliers.order(:id).search(params[:pgq], params[:page])
    return unless params[:select2]

    select2_render
  end

  # GET /suppliers/1
  # GET /suppliers/1.json
  def show; end

  # GET /suppliers/new
  def new; end

  # GET /suppliers/1/edit
  def edit; end

  # POST /suppliers
  # POST /suppliers.json
  def create
    respond_to do |format|
      if @supplier.save
        format.html { redirect_to @supplier, notice: "#{t('activerecord.models.supplier.one')} criado com sucesso" }
        format.json { render action: 'show', status: :created, location: @supplier }
      else
        format.html { render action: 'new' }
        format.json { render json: @supplier.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /suppliers/1
  # PATCH/PUT /suppliers/1.json
  def update
    respond_to do |format|
      if @supplier.update(supplier_params)
        format.html { redirect_to @supplier, notice: "#{t('activerecord.models.supplier.one')} atualizado com sucesso." }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @supplier.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /suppliers/1
  # DELETE /suppliers/1.json
  def destroy
    @supplier.destroy
    respond_to do |format|
      format.html { redirect_to suppliers_url }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def supplier_params
    sanitize_active_storage_params(Supplier, @supplier)
    params.require(:supplier).permit(:name, :address, :phone, :email, :cpf_cnpj)
  end

  def select2_render
    render json: Oj.dump(
      {
        results: @suppliers.map { |supplier| { text: supplier.to_s, id: supplier.id } },
        pagination: { more: @suppliers.next_page.present? }
      }, mode: :compat
    )
  end
end
