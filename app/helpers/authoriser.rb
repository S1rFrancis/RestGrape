module Authoriser
  def authorised?(request)
    request.headers["Api-Token"] == "secret123"
  end
end
