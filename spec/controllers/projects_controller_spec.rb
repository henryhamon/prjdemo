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
    FactoryGirl.create(:project, id: 1)

    project_json = { id: 1, client: "Damien White" }

    put :update, id: 1,
    project:  project_json

    expect(response.status).to eq 200
    body = JSON.parse(response.body)

    project_name = body['name']
    expect(project_name) == 'Damien White'
  end
  
  it "delete a project" do
    FactoryGirl.create(:project, id: 1)
    delete :destroy, id: 1
  
    expect(response.status).to eq 200
    body = JSON.parse(response.body)
    expect(body['state']).to eq('archived')
  end

  it "finish a project" do
    FactoryGirl.create(:project, state:'started', id: 1)
    get :finish, id: 1
  
    expect(response.status).to eq 200
    body = JSON.parse(response.body)
    expect(body['state']).to eq('finished')
  end
  
  it "finish a list of projects" do
    3.times do |t|
      FactoryGirl.create(:project, state:'started', id: t+1)
    end
  
    post :finish_all, projects: Project.all.map(&:id)
    expect(response.status).to eq 200
    body = JSON.parse(response.body)
    expect(body.size).to eq(3)
  end
end
