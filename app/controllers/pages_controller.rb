class PagesController < ApplicationController

  before_action :authenticate_user!

  def index
    @subject = Subject.find(params[:subject_id])
    @pages = @subject.pages.sorted.paginate(:page => params[:page], :per_page => 5)
  end

  def show
    @subject = Subject.find(params[:subject_id])
    @page = Page.find(params[:id])
  end

  def new
    @subject = Subject.find(params[:subject_id])
    @page = @subject.pages.new
    @subjects = Subject.order('position ASC')
    @page_count = @subject.pages.count + 1
  end

  def create
    @subject = Subject.find(params[:subject_id])
    @page = Page.new(page_params)
    if @page.save
      flash[:notice] = "Page created successfully!"
      redirect_to subject_page_path(@subject.id, @page.id)
    else
      @subject = Subject.find(params[:subject_id])
      @subjects = Subject.order('position ASC')
      @page_count = @subject.pages.count + 1
      render('new')
    end
  end

  def edit
    @subject = Subject.find(params[:subject_id])
    @page = Page.find(params[:id])
    @subjects = Subject.order('position ASC')
    @page_count = @subject.pages.count
  end

  def update
    @subject = Subject.find(params[:subject_id])
    @page = Page.find(params[:id])
    if @page.update_attributes(page_params)
      flash[:notice] = "Page updated successfully!"
      redirect_to subject_page_path
    else
      @subject = Subject.find(params[:subject_id])
      @subjects = Subject.order('position ASC')
       @page_count = @subject.pages.count
      render('edit')
    end
  end

  def delete
    @subject = Subject.find(params[:subject_id])
    @page = Page.find(params[:id])
  end

  def destroy
    @subject = Subject.find(params[:subject_id])
    page = Page.find(params[:id]).destroy
    flash[:notice] = "Page destroyed successfully!"
    redirect_to subject_pages_path
  end

  private

  def page_params
      params.require(:page).permit(:subject_id, :name, :permalink, :position, :visible)
  end

  

end