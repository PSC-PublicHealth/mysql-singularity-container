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

Initial configuration for the database server is supplied by means of the files `~/.my.cnf` and `~/.mysqlrootpw`.
Examples of these files can be found in the directory `example_config`

## Considerations

	* Use of this container requires netowrk access the first time that it is used, if using on a compute cluster within a compute job, ensure that the job has egress network access
	* Depending on the usage pattern, it may be advisable to store the DATADIR on local (rather than shared network) filesystem
	* The `startscript.sh` that sets up the database server container runs in the foreground; it is recommended that a terminal multiplxer such as `screen` or `tmux` is used
	* The `singularity` software must be available; if necessary `module load singularity`  

## Detailed Usage
 
	1. [Optional] Copy the `my.cnf` and `mysqlrootpw` files to your home directory: `cp example_config/my.cnf ~/.my.cnf; cp example_config/mysqlrootpw ~/.mysqlrootpw`.  Edit these files to customize.
	
	2. [Optional] Start `tmux` with: `tmux new -s SOMENAME` (note that it is possible to nest tmux sessions; if so, use `<ctrl>bb` to access the "inner" session and `<ctrl>b` to access the "outer" session

	3. Load the singularity module and cd to a working directory of your choice.

	4. Run the `startscript.sh` with two arguments: ARG1 = the location of the mysql data directory, ARG2 = the location of the socket direcotry

	5. `startscript.sh` will print a Perl DBI connect string, copy this for future use

	6. Create a new window in tmux: `<ctrl>bc`; load the singularity module in this new window

	7. Run the command: `alias mysql='singularity shell instance://mysql'`; you can then use the aliased `mysql` command to connect to the database with superuser privileges

	8. Use the Perl DBI string to interact using Perl.  Use the password that you specified in the `~/.mysqlrootpw` file

	9. When finished, switch to the window running the `startscript.sh` command with `<ctrl>w` (select with arrow keys).  Stop the `startscript.sh` with `<ctrl>c`.

	10. Run the command `singularity instance.stop mysql`

## Notes

It is possible to re-use the data directory. Simply tar the directory, copy to new location and untar.
