class User < ApplicationRecord
  has_secure_password
  has_many :movies
  has_many :comments
  has_many :favorites, class_name: 'Movie', foreign_key: 'user_id'
end
