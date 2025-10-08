module UpdatedAtHelper
  def request_has_been_updated(request)
    request.updated_at && request.updated_at > request.created_at
  end
end
