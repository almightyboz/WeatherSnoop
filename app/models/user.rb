class User < ActiveRecord::Base
  has_secure_password
  has_many :user_queries
  has_many :queries, through: :user_queries, source: :query

  # user show page should list query history

end
