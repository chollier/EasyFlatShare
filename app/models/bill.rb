class Bill
  include Mongoid::Document
  field :name, type: String

  embeds_many :expenses

  has_and_belongs_to_many :users, :inverse_of => :bills

  belongs_to :creator, :class_name => "User", :foreign_key => "creator_id", :inverse_of => :bills_owned

end
