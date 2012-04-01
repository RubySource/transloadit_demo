require 'test_helper'

class PicturesControllerTest < ActionController::TestCase
 
  context "#index" do
    setup  do
      get :index  
    end

    should "show a list item for each picture" do
      assert_select "ul" do |elements|
        assert_select "li", 2
      end
    end

    should "show a thumbnail for each picture" do
      imgs = css_select("img")
      assert_match /thumbnail/, imgs.first["src"]
      assert_match /thumbnail/, imgs.last["src"]
    end
 
    should "have an upload form" do
      assert_select "form"
    end
  end

  context "#show" do
    setup  do
      get :show, id: pictures(:one).id 
    end
    
    should "show full-size picture" do
      imgs = css_select("img") 
      assert_match /fullsize/, imgs.first["src"]
    end

    should "show name" do
      assert_select "span.name", 1
    end

    should "show description" do
      assert_select "span.description", 1
    end
  end

  context "#create" do
     
    should "create a new picture" do
      assert_difference "Picture.count", 1 do
        post :create, picture: {name: "Test Pic" , description: "This is my picture", assembly_id: "444"}
      end   
    end

    should "redirect to show the new picture" do
      post :create, picture: {name: "Test Pic" , description: "This is my picture", assembly_id: "444"}
      assert_redirected_to picture_url(Picture.last)
    end
  
  end
end
