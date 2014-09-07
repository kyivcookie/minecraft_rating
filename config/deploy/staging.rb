# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary server in each group
# is considered to be the first unless any hosts have the primary
# property set.  Don't declare `role :all`, it's a meta role.

role :app, %w{web412.webfaction.com}
role :web, %w{web412.webfaction.com}
role :db,  %w{web412.webfaction.com}

set :default_env, {
    'PATH' => "#{deploy_to}/bin:$PATH",
    'GEM_HOME' => "#{deploy_to}/gems",
    'RUBYLIB' => "#{deploy_to}/lib"
}

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server definition into the
# server list. The second argument is a, or duck-types, Hash and is
# used to set extended properties on the server.

# server 'example.com', user: 'deploy', roles: %w{web app}, my_property: :my_value

set :user, 'unrealm'
set :scm_username, 'AndreyPristupa'
set :use_sudo, false

# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult[net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start).
#
# Global options
# --------------
# set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
# }
#
# And/or per server (overrides global)
# ------------------------------------
server 'web412.webfaction.com',
       user: 'unrealm',
       roles: %w{web app},
       ssh_options: {
           user: 'user_name', # overrides user setting above
           # keys: %w(/home/user_name/.ssh/id_rsa),
           forward_agent: false,
           # auth_methods: %w(publickey password)
           password: 'hjujdyj7yjytujdyja'
       }
