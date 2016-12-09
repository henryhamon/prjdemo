require 'rails_helper'

RSpec.describe Project, type: :model do
  
  before do
    @executor = FactoryGirl.create :client
    @project = FactoryGirl.create :project
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
    

end
