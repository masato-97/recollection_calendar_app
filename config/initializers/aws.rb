require "aws-sdk-s3"

puts "AWS_BUCKET: #{ENV['AWS_BUCKET'].inspect}"
puts "AWS_REGION: #{ENV['AWS_REGION'].inspect}"
puts "AWS_ACCESS_KEY: #{ENV['AWS_ACCESS_KEY'].inspect}"
puts "AWS_SECRET_KEY: #{ENV['AWS_SECRET_KEY'].inspect}"

Aws.config.update(
  region: ENV["AWS_REGION"],
  credentials: Aws::Credentials.new(
    ENV["AWS_ACCESS_KEY"],
    ENV["AWS_SECRET_KEY"]
  )
)

if ENV["AWS_BUCKET"].nil? || ENV["AWS_BUCKET"].empty?
  puts "AWS_BUCKET 環境変数が設定されていません。S3_BUCKET をスキップします。"
  S3_BUCKET = nil
else
  puts "AWS_BUCKET 環境変数は設定されています。"
  S3_BUCKET = Aws::S3::Resource.new.bucket(ENV["AWS_BUCKET"])
end
