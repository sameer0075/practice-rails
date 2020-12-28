class Note < ApplicationRecord
	enum status: {draft:0,published:1}
	validates_presence_of :title,:body

	scope :draft,->{where(status:'draft')}
	scope :published,->{where(status:'published')}
end
