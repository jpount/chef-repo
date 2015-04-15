Overview
========

This is an attempt at separating cookbooks to enable them to be easily built and tested locally, incorporated into a CI process and combined into "environment" or
"infrastructure" components that represent a node or set of nodes

Chef Repo - the latest patterns bemoan the use of a monolithic chef repo and suggest that each cookbook should have it's own repo where a single cookbook is developed,
built, versioned and tested. 

References - The best resources I could find on the topic are listed below:

https://github.com/berkshelf/berkshelf/issues/535#issuecomment-18327975
http://blog.vialstudios.com/the-environment-cookbook-pattern/
https://www.youtube.com/watch?v=hYt0E84kYUI
http://nerds.airbnb.com/making-breakfast-chef-airbnb/
http://lists.opscode.com/sympa/arc/chef/2013-10/msg00307.html

Tools - The usual suspects
Chef
Kitchen
Vagrant
Berkshelf
Ruby
Git

Chef Solo - Solving the issues
We are not using Chef Server which a lot of patterns are based on. This means that when running chef on a specific node, it needs access to all relevant files locally
rather than refering back to the server. This limitation/benefit (depending on your view) is why some decisions have been made.

Patterns/Implementation
=======================

Follow the patterns suggested in the Youtube video with regard to categorising cookbooks. The most important categorisation for us are:
Toplevel or Wrapper cookbooks
Environment or Infrastrucutre cookbooks

The toplevel cookbooks are basically organisational cookbooks that wrap application cookbooks to produce a single deployable node for example a toplevel gitlab cookbook
would include the gitlab application cookbook but also apply any wrapper stuff such as different configuration or adding recipes to control the installation.
Each cookbook should have it's own repo

The environment or infrastructure cookbook sits above the top levels and acts as the infrastrucutre creator ie it may include one or more wrapper cookbooks, tie them
together and include the traditional Chef role, environment and databag directories. Sort of a mini chef repo for one or more components (wrapper scripts) ie an organisation may have tailored mysql and gitlab cookbooks (in their own repos). The Environment cook book could bring them together and include recipes to deploy them as separate nodes or on the same box, include different environments such as dev(vagrant) or cloud (aws) for instance

Next Steps
==========

Have a look in the cookbook repos and see how things hang together

