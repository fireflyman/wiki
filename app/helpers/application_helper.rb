# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
include TagsHelper  

 # def tag_cloud  
#@tags = Lemma.tag_counts  
   #end 
=begin
 def tag_cloud(tag_counts)
  ceiling = Math.log(tag_counts.max { |a,b| a.count <=> b.count }.count)
  floor = Math.log(tag_counts.min { |a,b| a.count <=> b.count }.count)
  range = ceiling - floor
    
  tag_counts.each do |tag|
  count = tag.count
  size = (((Math.log(count) - floor)/range)*66)+33
  yield tag, size
  end
 end
=end
end
