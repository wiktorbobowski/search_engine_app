# == Schema Information
#
# Table name: search_instances
#
#  id         :integer          not null, primary key
#  search_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SearchInstance < ActiveRecord::Base
  belongs_to :search
  has_and_belongs_to_many :results, :join_table => 'search_instance_results', :dependent => :destroy
  has_many :search_instance_results, :dependent => :destroy

  scope :newest, ->{order('created_at desc')}
end
