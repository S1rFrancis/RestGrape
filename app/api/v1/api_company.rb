class V1::APICompany < Grape::API
  extend Authoriser
  # rescue_from ActiveRecord::RecordNotFound do |e|
  #   error!("Unauthorized", 403)
  # end

  format :json

  desc "Create a new company"
  params do
    requires :name, type: String, desc: "Name of company"
    requires :description, type: String, desc: "Details of company"
  end

  post "/newCompany" do
    if V1::APICompany.authorised?(request)
      name = request["name"]
      description = request["description"]
      company = Company.where({ name: name, description: description })
      if company.blank?
        company = Company.new({ name: name, description: description })
        company.save
        { "response": "success" }
      else
        { "response": "failed" }
      end

    else
      { "response": "failed"}
    end
  end

  desc "Update an existing company"
  params do
    requires :id, type: Integer, desc: "Identification number of company"
    requires :name, type: String, desc: "New name of company"
    requires :description, type: String, desc: "New details of company"
  end

  post "/updateCompany" do
    if V1::APICompany.authorised?(request)
      id = request["id"]
      company = Company.find_by_id(id)

      if company.present?
        name = request["name"]
        description = request["description"]
        company.update({ name: name, description: description })
      else
        { "response": "inavlid update attempted" }
      end
    end
  end

  params do
    requires :id, type: Integer, desc: 'Company id.'
  end

    post "/deleteCompany" do
      if V1::APICompany.authorised?(request)
        id = request["id"]
        company = Company.find_by_id(id)

        if company.present?
          company.destroy
        else
          { "response": "invalid deletion attempted" }
        end
      end
    end

  get ":id" do
    V1::APICompany.authorised?(request) ? CompanyRepresenter.new(Company.find_by_id(params[:id])) : { "response": "you are not authorised to do this mate"}
  end

end
