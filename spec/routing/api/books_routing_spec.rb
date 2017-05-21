require "rails_helper"

RSpec.describe Api::BooksController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/api/books").to route_to("api/books#index")
    end


    it "routes to #show" do
      expect(:get => "/api/books/1").to route_to("api/books#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/api/books").to route_to("api/books#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/api/books/1").to route_to("api/books#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/api/books/1").to route_to("api/books#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/api/books/1").to route_to("api/books#destroy", :id => "1")
    end

  end
end
