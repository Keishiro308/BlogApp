class Post < ApplicationRecord
  has_rich_text :content
  Gutentag::ActiveRecord.call self

  validates :title,{presence: true}
  validates :content,{presence: true}


  def user
    return User.find_by(id: self.user_id)
  end

  def tags_as_string
    tag_names.join(', ')
  end

  def tags_as_string=(string)
    self.tag_names = string.split(/,\s*/)
  end
end
