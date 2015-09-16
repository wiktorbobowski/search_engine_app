# == Schema Information
#
# Table name: results
#
#  id         :integer          not null, primary key
#  title      :string
#  link       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  code       :string
#

class Result < ActiveRecord::Base

  before_save :strip_tags
  has_and_belongs_to_many :search_instances, :join_table => 'search_instance_results'

  validates_presence_of :title, :link

  def self.generate_code link, title
    Digest::MD5.hexdigest link + title
  end

  def self.url_parse link
    result = link.match(/url\?q=(.*)&sa=/)
    result[1] if result
  end

  def latest_per_query
    result = []
    search_instances.select('search_id').uniq.each { |search|
      instance = search_instances.newest.where(:search_id => search.search_id).first
      result << instance.search_instance_results.find_by(:result => self)
    }
    result
  end

  private

  def strip_tags
    self.code = Result.generate_code self.link, self.title
  end

end
