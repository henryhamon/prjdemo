require 'rails_helper'

RSpec.describe Api::V1::ProjectsController, type: :controller do
  
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
  
  describe "GET " do
    it "returns all the projects" do
      FactoryGirl.create :project, name: 'The Wall', client: 'Pink Floyd'
      FactoryGirl.create :project, name: 'Purple Rain', client: 'Prince'
      get :index
      body = JSON.parse(response.body)
      project_names = body.map{|project| project['name'] }
      expect(project_names).to match_array(['The Wall', 'Purple Rain'])
    end
    
    it "not returns archived the projects" do
      FactoryGirl.create :project, name: 'The Wall', client: 'Pink Floyd'
      FactoryGirl.create :project, name: 'Purple Rain', client: 'Prince'
      FactoryGirl.create :project, name: 'Love Symbol', client: 'Prince', state: 'archived'
      
      get :index
      body = JSON.parse(response.body)
      project_names = body.map{|project| project['name'] }
      expect(project_names).to match_array(['The Wall', 'Purple Rain'])
    end
  end
end
