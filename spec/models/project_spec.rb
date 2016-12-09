require 'rails_helper'

RSpec.describe Project, type: :model do
  
  before do
    @project = FactoryGirl.create :project
  end

  it "is not valid without a name" do
    project = Project.new(name: nil)
    expect(project).not_to be_valid
  end

  it "is valid with a name and client" do
    project = Project.new(name: "Death Star", client: "Darth Vader")
    expect(project).to be_valid
  end
  
  it 'has "new" state after initialize' do
    expect(@project.state).to eq("new") 
  end
  
  it 'states may be changed as new => started => finished' do
    expect(@project.state).to eq("new") 
    @project.start
    expect(@project.state).to eq("started") 
    @project.finish
    expect(@project.state).to eq("finished") 
  end

  it 'cannot finish after new' do
    expect(@project.state).to eq("new") 
    @project.finish
    expect(@project.state).to eq("new") 
  end

  it 'cannot to start after finish' do
    @project.start
    expect(@project.state).to eq("started") 
    @project.finish
    expect(@project.state).to eq("finished") 
    @project.start
    expect(@project.state).to eq("finished") 
  end
    
  it 'states may be changed as new => archived' do
    expect(@project.state).to eq("new") 
    @project.delete
    expect(@project.state).to eq("archived") 
  end
  
  it 'states may be changed as new => started => finished => archived' do
    expect(@project.state).to eq("new") 
    @project.start
    expect(@project.state).to eq("started") 
    @project.finish
    expect(@project.state).to eq("finished") 
    @project.delete
    expect(@project.state).to eq("archived") 
  end

  it 'accepts string as param too' do
    expect(@project.state).to eq("new") 
    @project.perform_event "start"
    expect(@project.state).to eq("started") 
    @project.perform_event "finish"
    expect(@project.state).to eq("finished") 
  end

  it 'add error if events havent event from params' do
    @project.perform_event :unknown_event
    expect(@project.state).to eq("new") 
    expect(@project.errors.messages.count).to eq(1) 
  end

  it 'should get datetime when finished' do
    expect(@project.state).to eq("new") 
    @project.start
    expect(@project.state).to eq("started") 
    @project.finish
    expect(@project.state).to eq("finished") 
    expect(@project.finished_at).to be
  end
    
  it 'should get datetime when archived' do
    expect(@project.state).to eq("new") 
    @project.delete
    expect(@project.state).to eq("archived") 
    expect(@project.archived_at).to be
  end

end
