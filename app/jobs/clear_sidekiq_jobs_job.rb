# frozen_string_literal: true

# Class to clear unattached blobs
class ClearSidekiqJobsJob < ActiveJob::Base
  queue_as :default

  def perform
    ActiveRecord::Base.connection.exec_query("DELETE from sidekiq_jobs where finished_at < '#{1.weeks.ago.utc.strftime("%Y-%m-%d %H:%M:%S")}'")
  end
end
