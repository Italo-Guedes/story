# frozen_string_literal: true

# Class to clear unattached blobs
class ClearActiveStorageUnattachedJob < ApplicationJob
  queue_as :default

  def perform(_options = {})
    ActiveStorage::Blob.unattached.find_each(&:purge)
  end
end
