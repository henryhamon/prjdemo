class Client < ActiveRecord::Base
  has_many :projects
  validates :name, presence: true, uniqueness: true, length: { minimum: 5 }
end
