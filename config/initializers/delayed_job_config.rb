Delayed::Worker.default_queue_name = 'search'
Delayed::Worker.delay_jobs = !Rails.env.test?
Delayed::Worker.destroy_failed_jobs = false
Delayed::Worker.max_run_time = 15.minutes
