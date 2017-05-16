class Contact < ActiveRecord::Base
  def name
    [first_name, last_name].join(' ')
  end

  validates :first_name, presence: true
	validates :last_name, presence: true
	validates :phone_number, numericality: true, length: { is: 10 }
  
end
