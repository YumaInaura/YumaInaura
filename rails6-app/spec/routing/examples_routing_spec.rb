require "rails_helper"

RSpec.describe ExamplesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/examples").to route_to("examples#index")
    end

    it "routes to #new" do
      expect(get: "/examples/new").to route_to("examples#new")
    end

    it "routes to #show" do
      expect(get: "/examples/1").to route_to("examples#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/examples/1/edit").to route_to("examples#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/examples").to route_to("examples#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/examples/1").to route_to("examples#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/examples/1").to route_to("examples#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/examples/1").to route_to("examples#destroy", id: "1")
    end
  end
end
