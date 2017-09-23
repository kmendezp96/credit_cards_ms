class CreditCard < ApplicationRecord
  #default_scope {order("CreditCard.created_at ASC")}
  scope :order_by_name, -> (type) {order("CreditCard.user_id  #{type}")}
  validates :number, :amount, :expiration_year, :expiration_month, :user_id, presence: {message: "This atributte can't be empty"}
  validates :number, uniqueness: {message: "this credit card is already in use"}
  validates :amount, numericality: {:greater_than => -1,message: "Must be greater than 0"}
  validates_format_of :number, :with =>  /[0-9]+/
  validates :number, length: { in: 14..20, message: "Must have at least 15 digits and lest than 20"}
  validates :expiration_month, numericality: {:greater_than => 0, :less_than => 12, message: "Months between 1 and 12"}
  validates :expiration_year, numericality: {:greater_than => 2017, :less_than => 2100, message: "Invalid year"}

  #validates :number, numericality: {:greater_than => 99999999999999, :less_than => 10000000000000000000, message: "Must have at least 15 digits and lest than 20"}

  #def self.load_credit_cards(page = 1, per_page = 10)
  #  includes()
  #    .paginate(:page => page, :per_page => per_page)
  #end
  #def self.credit_cards_by_id(id,columns)
  #  columns=columns ? columns+",credit_cards.*"
  #  .select(columns)
  #    .find_by_id(id)
  #end
  def self.credit_cards_by_user_id(user)
    #CreditCard.find_by user_id: user
    CreditCard.all.where(user_id: user.to_i)
  end
  #def self.credit_cards_by_number(number)
  #  columns=columns ? columns+"credit_cards.*"
    #load_credit_cards(page,per_page)
  #  .select(columns)
  #    .where('credit_cards.number = ?', number)
  #end

end
