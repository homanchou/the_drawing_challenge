class Admin::ManagePagesController < Admin::AdminController
  before_action :set_page, only: [:show, :edit, :update, :destroy]


  def index
    @pages = Page.page params[:page]
  end

  def show
    respond_with(@page)
  end

  def new
    @page = Page.new
  end

  def edit
  end

  def create
    @page = Page.new(page_params)
    @page.save
    redirect_to admin_manage_pages_path
  end

  def update
    @page.update(page_params)
    redirect_to admin_manage_pages_path
  end

  def destroy
    @page.destroy
    redirect_to admin_manage_pages_path
  end

  private
    def set_page
      @page = Page.find(params[:id])
    end

    def page_params
      params.require(:page).permit(:title, :body, :slug)
    end
end
