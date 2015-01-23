class SectionsController < ApplicationController

  before_action :authenticate_user!

  def index
    @subject = Subject.find(params[:subject_id])
    @page = @subject.pages.find(params[:page_id])
    @sections = @page.sections.sorted.paginate(:page => params[:page], :per_page => 5)
  end

  def show
    @subject = Subject.find(params[:subject_id])
     @page = @subject.pages.find(params[:page_id])

    @section = Section.find(params[:id])
  end

  def new
    @subject = Subject.find(params[:subject_id])
    @page = @subject.pages.find(params[:page_id])

    @section = @page.sections.new
    @pages = @subject.pages.order('position ASC')
    @section_count = @page.sections.count + 1
  end

  def create
    @subject = Subject.find(params[:subject_id])
    @page = @subject.pages.find(params[:page_id])
    @section = Section.new(section_params)
    if @section.save
      flash[:notice] = "Section created successfully!"
      redirect_to  subject_page_section_path(@subject.id, @page.id, @section.id)
    else
      @subject = Subject.find(params[:subject_id])
      @page = @subject.pages.find(params[:page_id])

      @pages = @subject.pages.order('position ASC')
      @section_count = @page.sections.count + 1
      render('new')
    end
  end

  def edit
     @subject = Subject.find(params[:subject_id])
     @section = Section.find(params[:id])
     @page = @subject.pages.find(params[:page_id])
     @pages = @subject.pages.order('position ASC')
     @section_count = @page.sections.count
  end

  def update
    @section = Section.find(params[:id])
    if @section.update_attributes(section_params)
      flash[:notice] = "Section updated successfully!"
      redirect_to  subject_page_section_path
    else
      @pages = @subject.pages.order('position ASC')
      @section_count = @page.sections.count
      render('edit')
    end
  end

  def delete
    @subject = Subject.find(params[:subject_id])
     @page = @subject.pages.find(params[:page_id])
    @section = Section.find(params[:id])
  end

  def destroy
    @subject = Subject.find(params[:subject_id])
     @page = @subject.pages.find(params[:page_id])
    section = Section.find(params[:id]).destroy
    flash[:notice] = "Section destroyed successfully!"
    redirect_to subject_page_sections_path
  end

  private

  def section_params
    params.require(:section).permit(:page_id, :name, :position, :visible, :content_type, :content)
  end

end
