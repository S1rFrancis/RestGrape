class V1::APIServices < Grape::API

  format :json

  params do
    requires :serv, type: String, desc: 'description of service'
    requires :price, type: Float, desc: 'cost of service'
    requires :duration, type: Integer, desc: 'duration of service'
    requires :disabled, type: Boolean, desc: 'is service available'
    requires :company_id, type: Integer, desc: 'ID number of associated company'
  end

  post "/newService" do
    authoriser = Authoriser.new
    service_helper = ServiceHelper.new

    company_id = request["company_id"]
    serv = request["serv"]
    price = request["price"]
    duration = request["duration"]
    disabled = request["disabled"]

    if authoriser.authorised?(request) && service_helper.uniqueCompanyService?(company_id, serv, price, duration, disabled)
      service_record = Service.create(service: serv, price: price, duration: duration, disabled: disabled, company_id: company_id)
      service_record.save
    else
      { "response": "failed to create service"}
    end
  end

  params do
    requires :id, type: Integer, desc: 'Service identification number'
    requires :serv, type: String, desc: 'description of service'
    requires :price, type: Float, desc: 'cost of service'
    requires :duration, type: Integer, desc: 'duration of service'
    requires :disabled, type: Boolean, desc: 'is service available'
  end

  post "/updateService" do
    authoriser = Authoriser.new
    service_helper = ServiceHelper.new
    id = request["id"]

    company_service = Service.find_by_id(id)
    if company_service.present?
      serv = request["serv"]
      price = request["price"]
      duration = request["duration"]
      disabled = request["disabled"]

      company_service.update({ service: serv, price: price, duration: duration, disabled: disabled })
    else
      { "response": "inavlid update attempted" }
    end
  end

  params do
    requires :id, type: Integer, desc: 'Service id'
  end

    post "/deleteService" do
      authoriser = Authoriser.new
      if authoriser.authorised?(request)
        id = request["id"]
        company_service = Service.find_by_id(id)

        if company_service.present?
          company_service.destroy
        else
          { "response": "invalid delete operation" }
        end
      end
    end

  params do
    requires :id, type: Integer, desc: 'Company id.'
  end

  get ":id" do
    authoriser = Authoriser.new
    authoriser.authorised?(request) ? Service.where({ id: params[:id], disabled: false}) : { "response": "you are not authorised to do this mate" }
  end
end
