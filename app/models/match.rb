class Match < ApplicationRecord
  belongs_to :user
  belongs_to :liked_user
end
