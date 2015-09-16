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

class BingSearch < Search

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
    search_result.search('#b_results h2 a')
  end
end
