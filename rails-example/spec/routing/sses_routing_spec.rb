require "rails_helper"

RSpec.describe SsesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/sses").to route_to("sses#index")
    end

    it "routes to #new" do
      expect(get: "/sses/new").to route_to("sses#new")
    end

    it "routes to #show" do
      expect(get: "/sses/1").to route_to("sses#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/sses/1/edit").to route_to("sses#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/sses").to route_to("sses#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/sses/1").to route_to("sses#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/sses/1").to route_to("sses#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/sses/1").to route_to("sses#destroy", id: "1")
    end
  end
end
