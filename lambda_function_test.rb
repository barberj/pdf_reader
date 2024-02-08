require 'minitest/autorun'

require './lambda_function.rb'

class LambdaFunctionTest < Minitest::Test
   def test_refresh_success
      encoded_pdf = File.open("pdf.fixture", "r").read
      body = JSON.generate(pdf: encoded_pdf)
      expected_body = ""
      out = lambda_handler(event: {"body" => body})
      assert out[:statusCode] == 200
      assert out[:body].include?("Order Number: ee1709b5")
   end
end
