require 'rails_helper'

RSpec.describe Note, type: :model do
  
  before do
    @project = FactoryGirl.create :project
    @note = FactoryGirl.create :note
  end
  
  it "belongs to a project" do
    @project.notes << @note
    expect(@note.project).to be @project
  end
  
  it 'has "active" state after initialize' do
    expect(@note.state).to eq("active") 
  end
 
  it 'should get datetime when archived' do
    expect(@note.state).to eq("active") 
    @note.delete
    expect(@note.state).to eq("archived") 
    expect(@note.archived_at).to be
  end
end
