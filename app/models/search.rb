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

require 'rubygems'
require 'mechanize'

class Search < ActiveRecord::Base
  has_many :search_instances, :dependent => :destroy
  has_and_belongs_to_many :users, :join_table => 'users_searches'

  before_update :do_search

  DESCENDANTS = [BingSearch, DuckduckgoSearch, GoogleSearch, YahooSearch]

  validates_presence_of :query

  default_scope { order('query ASC') }
  scope :for_user, -> (user) { joins(:users).where('users.id' => user.id) }


  def self.perform_search params, user
    raise "Not Found #{params[:type]}" if !DESCENDANTS.map(&:to_s).include? params[:type]

    search_engine = eval params[:type]
    unless search = search_engine.for_user(user).where(params).first
      Search.transaction do
        search = search_engine.create! :query => params[:query], :users => [user]
        search.do_search
      end
      search
    end
  end

  def do_search
    unless self.id
      self.save!
    end
    agent = Mechanize.new
    agent.get(engine_url) do |page|
      search_instance = self.search_instances.create!
      search_results(page).each_with_index do |box, index|
        link = parse_url box
        if link
          search_instance.search_instance_results.create! :result => create_result_if_not_exists(link, parse_title(box)), :position => index
        end
      end
    end
  end

  def results
    instance = self.search_instances.newest.first
    if instance
      instance.search_instance_results
    else
      []
    end
  end


  def type_to_human
    type.underscore.humanize
  end

  protected
  def create_result_if_not_exists link, text
    result = Result.find_by(:code => Result.generate_code(link, text))
    result = Result.create! :link => link, :title => text unless result
    result
  end

  def parse_url box
    raise "This method must be override in descendant classes"
  end

  def parse_title box
    raise "This method must be override in descendant classes"
  end

  def engine_url
    raise "This method must be override in descendant classes"
  end

  def engine_url
    raise "This method must be override in descendant classes"
  end

  def search_results page
    search_result = page.forms[0].tap { |search| search.p = self.query }.submit
    search_result.search('#web h3 a')
  end

end
