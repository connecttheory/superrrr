CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS', 
    :aws_access_key_id      => 'AKIAJJXT6MO2KXAEK2NQ', 
    :aws_secret_access_key  => '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', 
    :region                 => 'us-east-1'  
  }
  #config.permissions = 0666
  #config.storage = :s3
  config.fog_directory  = 'teststorage123'                     # required
  #config.s3_bucket = 'teststorage123'

end
