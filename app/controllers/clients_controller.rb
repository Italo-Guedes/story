# frozen_string_literal: true

# ClientsController
class ClientsController < ApplicationController
  load_and_authorize_resource

  # GET /clients
  # GET /clients.json
  def index
    @q = @clients.ransack(params[:q])
    @q.sorts = 'id desc' if @q.sorts.empty?
    @clients = @q.result
    @clients = @clients.order(:id).search(params[:pgq], params[:page])
    return unless params[:select2]

    select2_render
  end

  # GET /clients/1
  # GET /clients/1.json
  def show; end

  # GET /clients/new
  def new; end

  # GET /clients/1/edit
  def edit; end

  # POST /clients
  # POST /clients.json
  def create
    respond_to do |format|
      if @client.save
        format.html { redirect_to @client, notice: "#{t('activerecord.models.client.one')} criado com sucesso" }
        format.json { render action: 'show', status: :created, location: @client }
      else
        format.html { render action: 'new' }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clients/1
  # PATCH/PUT /clients/1.json
  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to @client, notice: "#{t('activerecord.models.client.one')} atualizado com sucesso." }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client.destroy
    respond_to do |format|
      format.html { redirect_to clients_url }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def client_params
    sanitize_active_storage_params(Client, @client)
    params.require(:client).permit(:name, :address, :phone, :email, :cpf_cnpj, :is_active)
  end

  def select2_render
    render json: Oj.dump(
      {
        results: @clients.map { |client| { text: client.to_s, id: client.id } },
        pagination: { more: @clients.next_page.present? }
      }, mode: :compat
    )
  end
end
