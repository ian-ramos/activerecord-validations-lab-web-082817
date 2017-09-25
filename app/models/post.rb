class Post < ActiveRecord::Base
  include ActiveModel::Validations
  validates :title, presence: true
  validates :content, length: {minimum: 250}
  validates :summary, length: {maximum: 250}
  validates :category, inclusion: {in: ["Fiction", "Non-Fiction"]}
  validate :non_clickbait

  def non_clickbait
    array = ["Won't Believe", "Secret", "Guess"]
    if self.title
      array.each do |string|
        if self.title.include?(string)
          return # if title includes phrase, then it's fine
        end
      end
      self.errors[:title] << "Not click baity enough."
    end
  end

end
