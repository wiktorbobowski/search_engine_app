# == Schema Information
#
# Table name: delayed_job_settings
#
#  id         :integer          not null, primary key
#  interval   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#


class DelayedJobSetting < ActiveRecord::Base

  @@new = DelayedJobSetting.new :interval => 15
  def self.instance
    instance = DelayedJobSetting.first
    unless instance
      @@new.save!
      instance = @@new
    end
    instance
  end

  private_class_method :create, :create!, :new
end
