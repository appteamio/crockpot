Crockpot Cookbook
=================
A selection of recipes to bootstrap a rails/php development and/or staging environment on Ubuntu. 

Requirements
------------

#### packages
- No outisde receipe required it's simpler that way.

Attributes
----------

#### In the Node
  "group": "deploy",   
  "port": 8989,   

  "user": {    
    "name": "deploy",    
    "password": "#Shadow_hashed_password_here" #use command: openssl passwd -1 "theplaintextpassword"    
  },   
  "git":{   
              "name": "jalil",   
              "email": "jalil@appteam.io"   
              },    
  "db": {    
    "root_password": "secret",    
    "user": {    
      "name": "deploy",    
      "password": "password"   
    }    
 
#### In the attributes folder
just replace already existing

Usage
-----
#### crockpot::default
  "run_list": [   
    "recipe[crockpot]",    
    "recipe[crockpot::users]",   
    "recipe[crockpot::ssh]",    
    "recipe[crockpot::nodejs]",    
    "recipe[crockpot::postgres]",    
    "recipe[crockpot::rbenv]",   
    "recipe[crockpot::redis]",   
    "recipe[crockpot::nginx]",   
    "recipe[crockpot::app]",   
    "recipe[crockpot::gitconf]"    
    ]   

References
----------
http://vladigleba.com/blog/2014/07/28/provisioning-a-rails-server-using-chef-part-1-introduction-to-chef-solo/

https://gorails.com/setup/ubuntu/14.10

