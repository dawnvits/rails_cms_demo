class PublicController < ApplicationController

  layout 'public'

  before_action :setup_subjects


  def index
  end

  def show
  	@page = Page.where(:permalink => params[:permalink], :visible => true).first
    if @page.nil?
      redirect_to root_path
    end
  end

  def setup_subjects
  	@subjects = Subject.visible.paginate(:page => params[:page]).sorted
  end
end
