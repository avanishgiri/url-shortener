class Url < ActiveRecord::Base

  belongs_to :user
  validates :shortened, uniqueness: true
  validates :url, :format => {:with => /[https?:\/\/]?[[\w-]+\.]*[\w-]+\.\w\w+\/*.*/, :message => "Validate url only!"}, uniqueness: true

  def increment
    counter = self.counter + 1
    self.update_attributes(counter: counter)
  end

  def generate_shortened
    if self.shortened.nil?
      new_short = SecureRandom.hex(5) 
      until self.update_attributes(shortened: new_short)
        new_short = SecureRandom.hex(5) 
      end
    end
    self.shortened
  end

end

#/
