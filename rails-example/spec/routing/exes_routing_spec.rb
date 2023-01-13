require "rails_helper"

RSpec.describe ExesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/exes").to route_to("exes#index")
    end

    it "routes to #new" do
      expect(get: "/exes/new").to route_to("exes#new")
    end

    it "routes to #show" do
      expect(get: "/exes/1").to route_to("exes#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/exes/1/edit").to route_to("exes#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/exes").to route_to("exes#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/exes/1").to route_to("exes#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/exes/1").to route_to("exes#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/exes/1").to route_to("exes#destroy", id: "1")
    end
  end
end
