# frozen_string_literal: true

class ActiveStorage::Representations::ProxyController < ActiveStorage::BaseController
  include ActiveStorage::SetBlob
  include ActiveStorage::SetHeaders

  def show
    representation = @blob.representation(params[:variation_key]).processed

    set_headers(representation.image.blob)

    @blob.service.download(representation.key) do |chunk|
      response.stream.write(chunk)
    end
  ensure
    response.stream.close
  end
end
