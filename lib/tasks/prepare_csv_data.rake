namespace :prepare do
  task :csv_data => :environment do
    importer = ImportCsvData.new
    importer.run
  end
end

require 'csv'
class ImportCsvData

  attr_accessor :company, :company_name, :company_description, :serv, :price, :duration, :disabled
  DATAPATH = Rails.root + "lib/data/companies_data.csv"

  def run
    data = CSV.read(DATAPATH)

    data[1..data.size].each do |row|
      @company_name = row[0]
      @company_description = row[1] + " - " + row[2]
      @serv = row[3]
      @price = row[4]
      @duration = row[5]
      @disabled = (row[6] == "true") ? true : false

      if uniqueCompany?
        company = Company.new({ name: @company_name, description: @company_description })
        company.save
      end

      if uniqueCompanyService?
        company = Company.where({ name: @company_name, description: @company_description }).first

        service_record = Service.create(service: @serv, price: @price, duration: @duration, disabled: @disabled, company_id: company.id)
        service_record.save
      end
    end
  end

  def uniqueCompany?
    record = Company.where({ name: @company_name, description: @company_description})
    record.blank? ? true : false
  end

  def uniqueCompanyService?
    company =  Company.where({ name: @company_name, description: @company_description}).first
    record = Service.where({ service: @serv, price: @price, duration: @duration, disabled: @disabled, company_id: company.id})
    record.blank? ? true : false
  end

end
