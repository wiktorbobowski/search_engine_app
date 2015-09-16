# == Schema Information
#
# Table name: searches
#
#  id         :integer          not null, primary key
#  query      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  type       :string
#

class DuckduckgoSearch < Search

  protected

  def engine_url
    Rails.configuration.bing_url
  end

  def parse_url box
    box[:href]
  end

  def parse_title box
    ActionView::Base.full_sanitizer.sanitize box.children.to_s
  end

  def search_results page
    search_result = page.forms[0].tap{|search| search.q = self.query}.submit
    search_result.search('h2').search('a')
  end
end
