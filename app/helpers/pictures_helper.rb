module PicturesHelper
  def url_for_picture(pic, type)
    settings = Settings.s3
    "http://s3.amazonaws.com/#{settings.bucket}/#{pic.assembly_id}/#{type}_#{pic.name}"  
  end
end
