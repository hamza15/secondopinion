class Review < ActiveRecord::Base

    validates :stars, :post, presence: true
    belongs_to :user
    belongs_to :doctor

end
