class CategoriesController < ApplicationController
  before_filter :authorize
  
  def index
    @categories = Category.find(:all, :order => 'name')
  end


  def new
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(params[:category])
      if @category.save
        redirect_to(categories_url, :notice => 'Category was successfully created.')
      else
        render :action => "new"
    end
  end

  def update
    @category = Category.find(params[:id])
      if @category.update_attributes(params[:category])
        redirect_to(categories_url, :notice => 'Category was successfully updated.')
      else
        render :action => "edit"
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
      redirect_to(categories_url)
  end
end
