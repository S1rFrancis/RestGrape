require 'test_helper'

class ServicesTest < ActionDispatch::IntegrationTest

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

  test "get enabled service 12" do
    url = "http://localhost:3000/api/v1/service/12"
    result = get(url).first

    assert result["id"] == 12
    assert result["service"] == "Design with HTML/CSS"
    assert result["price"] == 120.0
    assert result["duration"] == 30
    assert result["disabled"] == false
    assert result["company_id"] == 9
  end

  test "get disabled service 8" do
    url = "http://localhost:3000/api/v1/service/8"
    result = get(url)

    assert result.blank? == true
  end

  test "Create new service" do
    url = "http://localhost:3000/api/v1/service/newService"
    data = {
             "serv": "keeping you off the streets",
             "price": 100, "duration": 60,
             "disabled": false,
             "company_id": 3
           }
    result = post(url, data)

    assert result.class == Net::HTTPCreated
  end

  test "Update service: IBM New York to Well rounded Ruby" do
    url = "http://localhost:3000/api/v1/service/updateService"
    id = 2
    data = { "id": id,
             "serv": "Well rounded Ruby",
             "price": 200,
             "duration": 90,
             "disabled": false
           }
    result = post(url, data)
    
    assert result.class == Net::HTTPCreated
  end

  test "Delete Advanced Angular JS service" do
    url = "http://localhost:3000/api/v1/service/deleteService"
    id = 14
    data = { "id": id }
    result = post(url, data)

    assert result.class == Net::HTTPCreated
  end
end
