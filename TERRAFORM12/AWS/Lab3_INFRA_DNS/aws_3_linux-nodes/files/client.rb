chef_server_url        "https://chef-server.mylabserver.com/organizations/chef-org"
validation_client_name "chef-org-validator"
validation_key         "chef-org-validator.pem"
trusted_certs_dir      "/etc/chef/trusted_certs"
log_location           "/var/log/chef/client.log"
ssl_verify_mode        :verify_none
verify_api_cert        false
