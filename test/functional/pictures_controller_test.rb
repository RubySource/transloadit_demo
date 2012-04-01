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
      assert_select "h2.name", 1
    end

    should "show description" do
      assert_select "p.description", 1
    end
  end

  context "#create" do
    setup  do
      @tl_params = "{\"assembly_id\":\"62d18d9c77594275db936099f506a4db\",\"uploads\":[{\"id\":\"d15482c0a4000710496278d21ec8172c\",\"name\":\"image001.png\",\"basename\":\"image001\",\"ext\":\"png\"}], \"template_id\": \"889870b06e184e15a13d5689a1925b61\", \"redirect_url\": \"http://localhost:3000/pictures\" }" 
    end
    should "create a new picture" do
      assert_difference "Picture.count", 1 do
        post :create, picture: {description: "This is my picture" }, transloadit: @tl_params
      end   
    end

    should "redirect to show the new picture" do
      post :create, picture: {description: "This is my picture"}, transloadit: @tl_params
      assert_redirected_to picture_url(Picture.last)
    end
  
  end
end
