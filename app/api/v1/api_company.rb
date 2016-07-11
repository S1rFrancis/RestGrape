class V1::APICompany < Grape::API

  # rescue_from ActiveRecord::RecordNotFound do |e|
  #   error!("Unauthorized", 403)
  # end
  
  format :json

  params do
    requires :id, type: Integer, desc: 'Company id.'
  end
  
  get ":id" do
    CompanyRepresenter.new(Company.find_by_id(params[:id]))
  end
end