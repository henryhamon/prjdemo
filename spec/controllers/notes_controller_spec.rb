require 'rails_helper'

RSpec.describe Api::V1::NotesController, type: :controller do

  
  before do
    @project = FactoryGirl.build(:project)
    @project.save
  end
 
  it "create a note" do
    note_json = {description: "Starting the test",project_id: @project.id}
    post :create, project_id: @project.id, note: note_json
    expect(response.status).to eq 200
  end
  
  it "delete a project" do
    FactoryGirl.create :note, description: 'Use your illusion 1', project_id: @project.id, id: 1
    delete :destroy, project_id: @project.id, id: 1
  
    expect(response.status).to eq 200
    body = JSON.parse(response.body)
    expect(body['state']).to eq('archived')
  end
end
