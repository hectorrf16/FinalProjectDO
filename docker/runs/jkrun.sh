# !/bin/bash

echo "Installing Jenkins Plugins"
jenkins-plugin-cli --plugin-file /tmp/plugins/plugins.txt
echo "Finished"