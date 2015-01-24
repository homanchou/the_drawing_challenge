class AboutController < ApplicationController

  def index
   @pages = Page.page params[:page]
  end

  def show
    @page = Page.find_by_slug(params[:id])
  end

end
