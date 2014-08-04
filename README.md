A simple Sinatra app that takes a provided chef role and enumerates nodes into a rundeck readable project format.

## Usage

In the config folder of the project place your knife.rb configuration file and your .pem files.

Change directory to the bin folder and execute ./chef-rundeck

The web server will listen on port 4567 and requests are made via http://<host>:4567/role/<role name>

E.g. for a role called "chef_is_awesome" on localhost you would use the URL: http://localhost:4567/role/chef_is_awesome

You can use this URL when setting up projects in rundeck.

## Notes & Limitations

This was developed on Ubuntu Linux. The app should run on any system with ruby v1.9 installed. The wrapper script in bin/chef-rundeck is a bash script, if you want to run this on windows or *nix platform without Bash you'll have to write your own wrapper.

The app does not yet enumerate all node data for the nodes - I only needed node name for the time being, and all of my nodes are Unix based. I do plan to come back and make this script more robust and provide more accurate data in the future.

## License

Original code by Andrew DuFour under Apache v2 license. See the LICENSE file for details.