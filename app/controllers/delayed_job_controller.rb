class DelayedJobController < ApplicationController
  before_action :retriev_internal_settings

  def edit_interval

  end

  def update_interval
    @delayed_job_settings.update_columns params.require('delayed_job_setting').permit(:interval)
    GoogleSearchJob.schedule(run_every: DelayedJobSetting.instance.interval.minutes)
  end

  private
  def retriev_internal_settings
    @delayed_job_settings = DelayedJobSetting.instance
  end
end
