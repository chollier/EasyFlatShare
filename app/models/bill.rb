class Bill
  include Mongoid::Document
  field :name, type: String

  embeds_many :expenses
end
