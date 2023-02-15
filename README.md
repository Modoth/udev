ubuntu container for development.

# Usage

* Default user `dev` with default password `dev`

* Init file: `/home/dev/.commons/main/start`

* Each subfolders of `/home/dev/.commons/` may contain a `.install` file which will be executed with root user when container runs, and a '.rc' file which will be executed whth dev user when container starts.
