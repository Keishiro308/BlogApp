class Follow < ApplicationRecord
  validates :user_id,{presence:true}
  validates :author_id,{presence:true}

  def author
    return User.find_by(user_id: self.author_id)
  end

  def user
    return User.find_by(user_id: self.user_id)
  end
end
