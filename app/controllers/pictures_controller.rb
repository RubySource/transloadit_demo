class PicturesController < ApplicationController
  
  def index
    @picture = Picture.new
    @pictures = Picture.all
  end

  def show
    @picture = Picture.find(params[:id]) 
  end

  def create
    tl_params= ActiveSupport::JSON.decode(params["transloadit"] )
    params[:picture][:assembly_id] = tl_params["assembly_id"]
    params[:picture][:name] = "#{tl_params["uploads"][0][ "basename" ]}.#{tl_params["uploads"][0][ "ext" ].downcase}" 
    @picture = Picture.create!(params[:picture])
    redirect_to @picture
  end
end
