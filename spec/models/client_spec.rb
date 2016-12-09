require 'rails_helper'

RSpec.describe Client, type: :model do
  it "is not valid without a name" do
    client = Client.new(name: nil)
    expect(client).not_to be_valid
  end
  
  it "is valid with a name" do
    client = Client.new(name: 'Tabajara')
    expect(client).to be_valid
  end
end
