# Load Houston
require "houston/application"

# Configure Houston
Houston.config do

  # Houston should load config/database.yml from this module
  # rather than from Houston Core.
  root Pathname.new File.expand_path("../../..",  __FILE__)

  # Give dummy values to these required fields.
  host "houston.test.com"
  secret_key_base "b98bd5f814a73b04c8deecaf7d04a1"
  mailer_sender "houston@test.com"

  # Mount this module on the dummy Houston application.
  use :statuses

end
