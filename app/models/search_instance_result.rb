# == Schema Information
#
# Table name: search_instance_results
#
#  id                 :integer          not null, primary key
#  search_instance_id :integer
#  result_id          :integer
#  position           :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class SearchInstanceResult < ActiveRecord::Base
  belongs_to :search_instance
  belongs_to :result, :dependent => :destroy

  def title
    result.title
  end

  def link
    result.link
  end

  def query
    search_instance.search.query
  end

  def search_type
    search_instance.search.type_to_human
  end

  def trend
    first = latest
    second = all_instances_of_search.second
    (second.position - first.position) if first && second
  end

  def appearance
    all_instances_of_search.count
  end

  private

  def all_instances_of_search
    SearchInstanceResult.joins(:search_instance).where(:result => result, 'search_instances.search_id' => search_instance.search_id)
  end

  def latest
    SearchInstanceResult.joins(:search_instance).where(:result => result, 'search_instances.search_id' => search_instance.search_id).first
  end

end
