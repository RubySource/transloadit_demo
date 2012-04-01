class PicturesController < ApplicationController
 
  before_filter :extract_tl_parameters, only: :create

  def index
    @picture = Picture.new
    @pictures = Picture.all
  end

  def show
    @picture = Picture.find(params[:id]) 
  end

  def create
    @picture = Picture.create!(params[:picture])
    redirect_to @picture
  end

  private

  def extract_tl_parameters
    tl_params= ActiveSupport::JSON.decode(params["transloadit"] )
    params[:picture][:assembly_id] = tl_params["assembly_id"]
    params[:picture][:name] = generate_file_name(tl_params)  
  end

  def generate_file_name(tl_params)
    "#{tl_params["uploads"][0]["basename"]}.#{tl_params["uploads"][0][ "ext" ].downcase}"
  end
end
