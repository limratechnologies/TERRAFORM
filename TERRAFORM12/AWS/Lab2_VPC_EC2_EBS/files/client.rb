chef_server_url  "https://chef-server.example.com/organizations/chef-org"
validation_client_name "chef-validator"
log_location   STDOUT
trusted_certs_dir "/etc/chef/trusted_certs"

log_location '/var/log/chef/client.log'
ssl_verify_mode :verify_none
verify_api_cert false

