# frozen_string_literal: true

# <%= class_name.pluralize %>Controller
class <%= class_name.pluralize %>Controller < ApplicationController
  load_and_authorize_resource

  # GET /<%= table_name %>
  # GET /<%= table_name %>.json
  def index
    @<%= table_name %> = @<%= table_name %>.order(:id).search(params[:q], params[:page])
    return unless params[:select2]

    render json: Oj.dump({
                           results: @<%= table_name %>.map { |<%= singular_table_name %>| { text: <%= singular_table_name %>.to_s, id: <%= singular_table_name %>.id } },
                           pagination: { more: @<%= table_name %>.next_page.present? } 
                         }, mode: :compat)
  end

  # GET /<%= table_name %>/1
  # GET /<%= table_name %>/1.json
  def show; end

  # GET /<%= table_name %>/new
  def new; end

  # GET /<%= table_name %>/1/edit
  def edit; end

  # POST /<%= table_name %>
  # POST /<%= table_name %>.json
  def create
    respond_to do |format|
      if @<%= singular_table_name %>.save
        format.html { redirect_to @<%= singular_table_name %>, notice: "#{t('activerecord.models.<%= singular_table_name %>.one')} criado com sucesso" }
        format.json { render action: 'show', status: :created, location: @<%= singular_table_name %> }
      else
        format.html { render action: 'new' }
        format.json { render json: @<%= singular_table_name %>.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /<%= table_name %>/1
  # PATCH/PUT /<%= table_name %>/1.json
  def update
    respond_to do |format|
      if @<%= singular_table_name %>.update(<%= singular_table_name %>_params)
        format.html { redirect_to @<%= singular_table_name %>, notice: "#{t('activerecord.models.<%= singular_table_name %>.one')} atualizado com sucesso." }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @<%= singular_table_name %>.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /<%= table_name %>/1
  # DELETE /<%= table_name %>/1.json
  def destroy
    @<%= singular_table_name %>.destroy
    respond_to do |format|
      format.html { redirect_to <%= table_name %>_url }
      format.json { head :no_content }
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def <%= singular_table_name %>_params
      sanitize_active_storage_params(<%= class_name %>, @<%= singular_table_name %>)
      params.require(:<%= singular_table_name %>).permit(<%= (attributes.map { |a| (a.type.to_s == "references" ? ":"+a.name+"_id" : ":"+a.name)}).join(", ") %>)
    end
end
