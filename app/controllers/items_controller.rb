class ItemsController < ApplicationController
  before_filter :authorize, :except => [:index]
  
  def index
     @items = Item.find(:all, :order => 'created_at ASC')
     @items_by_category = @items.group_by(&:category)
  end

  def new
    @item = Item.new
    render :layout => "item_form"
  end

  def edit
    @item = Item.find(params[:id])
    render :layout => "item_form"
  end

  def create
    @item = Item.new(params[:item])
      if @item.save
        redirect_to(items_url, :notice => 'Item was successfully created.')
      else
        render :action => "new", :layout => 'item_form'
    end
  end

  def update
    @item = Item.find(params[:id])
      if @item.update_attributes(params[:item])
        redirect_to(items_url, :notice => 'Item was successfully updated.')
      else
        render :action => "edit"
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to(items_url, :notice => 'Item was successfully deleted.')
  end
end
