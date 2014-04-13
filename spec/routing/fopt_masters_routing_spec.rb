require "spec_helper"

describe FoptMastersController do
  describe "routing" do

    it "routes to #index" do
      get("/fopt_masters").should route_to("fopt_masters#index")
    end

    it "routes to #new" do
      get("/fopt_masters/new").should route_to("fopt_masters#new")
    end

    it "routes to #show" do
      get("/fopt_masters/1").should route_to("fopt_masters#show", :id => "1")
    end

    it "routes to #edit" do
      get("/fopt_masters/1/edit").should route_to("fopt_masters#edit", :id => "1")
    end

    it "routes to #create" do
      post("/fopt_masters").should route_to("fopt_masters#create")
    end

    it "routes to #update" do
      put("/fopt_masters/1").should route_to("fopt_masters#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/fopt_masters/1").should route_to("fopt_masters#destroy", :id => "1")
    end

  end
end
