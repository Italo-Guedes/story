# frozen_string_literal: true

# /admin/users
class UsersController < ApplicationController
  load_and_authorize_resource
  
  # GET /users
  # GET /users.json
  def index
    @q = @users.ransack(params[:q])
    @q.sorts = 'id desc' if @q.sorts.empty?
    @users = @q.result
    @users = @users.search(params[:pgq], params[:page])
    return unless params[:select2]

    # As a universal way of enabling select2 autocomplete,
    # we need to return, on each index action, a json with their format
    render json: Oj.dump(
      {
        results: @users.select(:id, :name).map { |user| { text: user.to_s, id: user.id } },
        pagination: @users.next_page.present?
      }, mode: :compat
    )
  end

  # GET /users/1
  # GET /users/1.json
  def show; end

  # GET /users/new
  def new; end

  # GET /users/1/edit
  def edit; end

  # POST /users
  # POST /users.json
  def create
    @user.is_active = true
    @user.confirmed_at = Time.zone.now

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'Usuário criado com sucesso' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if params[:user][:password].blank?
      params[:user].delete :password
      params[:user].delete :password_confirmation
    end
    params[:user].delete :is_active unless current_user.has_role?(:admin) || current_user.has_role?(:super_admin)

    respond_to do |format|
      if @user.update(user_params)
        sign_in @user, bypass: true if @user.id == current_user.id
        format.html { redirect_to @user, notice: 'Usuário atualizado com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    sanitize_active_storage_params(User, @user)
    sanitize_role_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :locale, :is_active, :avatar, role_ids: [])
  end

  def sanitize_role_params
    params[:user][:role_ids] &= Role.allowed_roles(current_user).pluck(:id).map(&:to_s) if params[:user] && params[:user][:role_ids]
  end
end
