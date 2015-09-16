class GoogleSearchJob
  include Sidekiq::Worker
  def perform
      Search.all.each do |query|
        query.perform_google_search
      end
  end
end
