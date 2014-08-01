# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary server in each group
# is considered to be the first unless any hosts have the primary
# property set.  Don't declare `role :all`, it's a meta role.

set :deploy_to, "/var/www/#{application}"
set :rails_env, "production"

role :web, "www.recommendationengine.co"
role :app, "www.recommendationengine.co"
role :db, "www.recommendationengine.co", :primary => true

disable_path = "/var/www/hiyou_server/current/public"

after "deploy:update_code", "deploy:migrate"