class Bill
  include Mongoid::Document
  field :name, type: String

  embeds_many :expenses

  has_and_belongs_to_many :users
end
