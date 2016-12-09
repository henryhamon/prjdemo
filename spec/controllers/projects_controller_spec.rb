require 'rails_helper'

RSpec.describe Api::V1::ProjectsController, type: :controller do

  it "returns http success" do
    get :index
    expect(response).to have_http_status(:success)
  end
  
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
  
  
  it "create a project" do
    project_json = { name: 'Hey Joe', client: 'Hendrix' }
    
    post :create, project: project_json
    expect(response.status).to eq 200

  end
  
  it "updates the specified project" do
    FactoryGirl.create :project, name: 'X wing', client: 'John Doe', id: 1

    project_json = { id: 1, client: "Damien White" }

    put :update, id: 1,
    project:  project_json

    expect(response.status).to eq 200

    body = JSON.parse(response.body)

    project_name = body['name']
    expect(project_name) == 'Damien White'
  end
  

end
