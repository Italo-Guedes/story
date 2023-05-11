# frozen_string_literal: true

# /admin/users
class VersionsController < ApplicationController
  include Behaveable::ResourceFinder
  include Behaveable::RouteExtractor

  before_action :init

  def index
    model = params[:model_name].to_sym
    @versions = PaperTrail::Version.where(event: 'destroy', item_type: params[:model_name].classify)
                                   .order(id: :desc)
                                   .paginate(page: params[:page])
    self.class.module_eval { attr_accessor model }
    send("#{params[:model_name]}=", @versions)
    render "#{params[:model_name]}/index"
  end

  def show
    model = params[:model_name].singularize.to_sym
    @version = PaperTrail::Version.find(params[:id]).reify
    self.class.module_eval { attr_accessor model }
    send("#{model}=", @version)
    render "#{params[:model_name]}/show"
  end

  private

  def init
    authorize! :read, :deleted_records
    @deleted = true
    return if self.send("#{params[:model_name]}_path") rescue nil

    redirect_to root_path
  end
end
