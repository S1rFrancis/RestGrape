require 'test_helper'
require 'net/http'

class CompaniesTest < ActionDispatch::IntegrationTest

  def get(url)
    uri = URI(url)
    http = Net::HTTP.new(uri.host, uri.port)

    request = Net::HTTP::Get.new(uri.request_uri)
    request.add_field("API-Token", "secret123")
    result = JSON.parse(http.request(request).body)
  end

  def post(url, data)
    uri = URI(url)
    header = { "API-Token": "secret123" }
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.path, header)
    request.set_form_data(data)
    http.request(request)
  end

  test "google_berlin" do
    url = "http://localhost:3000/api/v1/1"
    result = get(url)

    assert result["name"] == "Google"
   end

   test "Create google Japan" do
     url = "http://localhost:3000/api/v1/newCompany"
     data = {
              "name": "Google",
              "description": "Japan - ASIA"
            }
     result = post(url, data)

     assert result.class == Net::HTTPCreated
   end

   test "Update company: IBM New York to IBM Louisiana" do
     url = "http://localhost:3000/api/v1/updateCompany"
     header = { "API-Token": "secret123" }
     id = 10
     data = {
              "id": id,
              "name": "IBM",
              "description": "Louisiana - US"
            }
     result = post(url, data)

     assert result.class == Net::HTTPCreated
   end

   test "Delete Apple New York and all associated services" do
     url = "http://localhost:3000/api/v1/deleteCompany"
     id = 4
     data = { "id": id }
     result = post(url, data)

     assert result.class == Net::HTTPCreated
   end
end
