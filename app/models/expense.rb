class Expense
  include Mongoid::Document
  field :name, type: String
  field :details, type: String
  field :amount, type: BigDecimal
  field :date, type: Date, default: Date.today

  embedded_in :bill

  belongs_to :creator, :class_name => "User", :foreign_key => "creator_id", :inverse_of => :expenses_owned

  attr_accessible :name, :details, :amount, :date
end
