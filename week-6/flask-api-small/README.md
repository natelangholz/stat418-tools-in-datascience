# Simple Flask API

This is a simple example of a Flask API. The environment again is created through a `docker-compose` command, that again references the corresponding Dockerfile and requirements.txt file. 

First as usual you will need to sync your repo to pull the new files. To run this API, change your directory to the docker folder and run:

`docker-compose up`

If it has created the localhost server correctly you will not get your prompt back. You will need to open a new terminal (be in the same directory) and run the following curl command to get a response

`curl http://localhost:5000/`

This API simply is an example of the Power of Two. Run the following curl command to see the results. Change the 12 to a different number. Change the x to a different letter. What happens?


`curl -H "Content-Type: application/json" -X POST -d '{"x":"12"}' "http://localhost:5000/power_of_two"`

To stop your server running the API, type `ctrl-C`. As usual, check to see if you have any docker containers running using `docker container ls` and stop them through `docker container kill <container-name>`
