class V1::APIRoot < Grape::API

  rescue_from ActiveRecord::RecordNotFound do |e|
    error!("Unauthorized", 403)
  end
  
  format :json

  get do
    {boom: 200}
  end
end