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

class GoogleSearch < Search

  protected

  def engine_url
    Rails.configuration.google_url
  end

  def parse_url box
    result = box[:href].match(/url\?q=(.*)&sa=/)
    result[1] if result
  end

  def parse_title box
    box.text
  end

  def search_results page
    search_result = page.forms[0].tap{|search| search.q = self.query}.submit
    search_result.search('#search #ires h3 a')
  end
end
