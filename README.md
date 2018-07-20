# mysql-singularity-container

A simple mysql database available as a singularity container

## Acknowledgements

This is based on the Iowa State University High Performance Computing MySQL Server Guide available here:

https://www.hpc.iastate.edu/guides/containers/mysql-server

It also makes use of the ISU-HPC/mysql singularity container available on singularityhub here:

https://singularity-hub.org/collections/937/usage

## Usage Summary

A singularity container can be used to package complex software installations or workflows into a simple, reproducible executable image.
This image can be run (but not modified, except in certain constrained ways) without the need for superuser privileges.

As it is used here it enables users to have full control privileges over a local or remotely hosted mysql database.
All *database* superuser privileges (create, drop, flush, etc) are granted to the user, as is the location of the writable data directory.

## Detailed Usage

 
