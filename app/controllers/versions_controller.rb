# frozen_string_literal: true

# /admin/users
class VersionsController < ApplicationController
  include Behaveable::ResourceFinder
  include Behaveable::RouteExtractor

  before_action :init

  def index
    versions_load
    model = params[:model_name].to_sym
    self.class.module_eval { attr_accessor model }
    public_send("#{params[:model_name]}=", @versions)
    render "#{params[:model_name]}/index"
  end

  def show
    model = params[:model_name].singularize.to_sym
    @version = PaperTrail::Version.find(params[:id]).reify
    self.class.module_eval { attr_accessor model }
    public_send("#{model}=", @version)
    render "#{params[:model_name]}/show"
  end

  private

  def init
    authorize! :read, :deleted_records
    @deleted = true
    begin
      return if public_send("#{params[:model_name]}_path")
    rescue StandardError
      nil
    end

    redirect_to root_path
  end

  def versions_load
    @versions = PaperTrail::Version.where(event: 'destroy', item_type: params[:model_name].classify)
                                   .order(id: :desc)
                                   .paginate(page: params[:page])
  end
end
