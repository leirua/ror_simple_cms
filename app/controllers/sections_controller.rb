class SectionsController < ApplicationController
  
  layout 'admin'

  before_action :confirm_logged_in
  before_action :find_page
  before_action :section_count, :only => [:new, :create, :edit, :update]

  def index
  	@sections = @page.sections.sorted
  end

  def show
    @section = Section.find(params[:id])
  end

  def new
    @section = Section.new(:page_id => @page.id)
    @pages = Page.sorted
  end

  def create
    @section = Section.new(section_params)
    @section.page = @page
    if @section.save
      flash[:notice] = "Section created successfully"
      redirect_to(section_path(@section, :page_id => @page.id))
    else
      flash[:notice] = "Error in saving"
      render('new')
    end
  end

  def edit
    @section = Section.find(params[:id])
  end

  def update
    @section = Section.find(params[:id])
    if @section.update_attributes(section_params)
      flash[:notice] = "Section updated successfully"
      redirect_to(section_path(@section, :page_id => @page.id))
    else
      flash[:notice] = "Error in updating"
      render('edit')
    end
  end

  def delete
    @section = Section.find(params[:id])
  end

  def destroy
    @section = Section.find(params[:id])
    if @section.destroy
      flash[:notice] = "Section deleted successfully"
      redirect_to(sections_path(:page_id => @page.id))
    else
      flash[:notice] = "Error in updating"
      redirect_to(delete_section_path(@section))
    end
  end

  private
  def section_params
    params.require(:section).permit(:name, :position, :visible, :content_type, :content)
  end

  def find_page
    @page = Page.find(params[:page_id])
  end

  def section_count
    @section_count = @page.sections.count
    actions = ['new','create']
    @section_count += 1 if actions.include?(params[:action])
  end
end
