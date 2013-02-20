class Expense
  include Mongoid::Document
  field :title, type: String
  field :details, type: String
  field :amount, type: BigDecimal
  field :date, type: Date

  embedded_in :bill
end
