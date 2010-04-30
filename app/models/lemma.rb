class Lemma < ActiveRecord::Base
    has_many :coauthors
    has_many :users, :through => :coauthors
      
  def contains?(user)
    not contains(user).nil?
  end
 
  def contains(user)
    coauthors.find_by_user_id(user)
  end
end
