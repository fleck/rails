# frozen_string_literal: true

module ActiveStorage
  class DeliveryMethod::Redirect < DeliveryMethod
    def initialize(options = {})
      @options = { only_path: true }.merge(options)
    end

    def representation_url(representation, url_options: {})
      Rails.application.routes.url_helpers.route_for(
        :rails_blob_representation,
        representation.blob.signed_id,
        representation.variation.key,
        representation.blob.filename,
        @options.merge(url_options)
      )
    end

    def blob_url(signed_id, filename, url_options: {})
      Rails.application.routes.url_helpers.route_for(
        :rails_service_blob,
        signed_id,
        filename,
        @options.merge(url_options)
      )
    end
  end
end
