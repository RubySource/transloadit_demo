require 'test_helper'

class PicturesHelperTest < ActionView::TestCase

  context "A picture url" do
    setup do
      @one = pictures(:one)  
    end

    should "match the bucket and url type" do
      assert_equal "http://s3.amazonaws.com/#{Settings.s3.bucket}/#{@one.assembly_id}/thumbnail_#{@one.name}", url_for_picture(@one, :thumbnail)
    end
  end
end
