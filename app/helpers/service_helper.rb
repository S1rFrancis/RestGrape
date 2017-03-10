module ServiceHelper
  def uniqueCompanyService?(company_id, serv, price, duration, disabled)
    company =  Company.find_by_id(company_id)
    record = company

    if company.presence
      record = Service.where({ service: serv,
                               price: price,
                               duration: duration,
                               disabled: disabled,
                               company_id: company.id
                               })
    end
    (record.blank? && !record.nil?) ? true : false
  end
end
