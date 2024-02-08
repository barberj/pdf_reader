require 'pdf-reader'
require 'json'
require 'logger'

def decode_base64(str)
  if !str.end_with?("=") && str.length % 4 != 0
    str = str.ljust((str.length + 3) & ~3, "=")
  end
  str.unpack1( 'm' )
end

def lambda_handler(event:, context: {})
  logger = Logger.new($stdout)

  payload = JSON.parse(event["body"])

  encoded_pdf = payload["pdf"]
  reader = PDF::Reader.new(StringIO.new(decode_base64(payload["pdf"])))
  pdf_text = reader.pages.map(&:text).join("\r\n")
  { statusCode: 200, body: pdf_text }
end
