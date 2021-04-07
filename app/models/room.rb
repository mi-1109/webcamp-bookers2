class Room < ApplicationRecord
  has_many :chats
  #そのルームにいるユーザ数が複数だから
  has_many :user_rooms
end
