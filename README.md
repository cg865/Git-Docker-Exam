
About the Application
This Python application takes one or more image files and combines them into a single PDF file in an "output" folder.

## Build Instructions


Build the Docker image:

docker build -t convert_image_to_pdf .

## Run Instructions


Run the container with a volume mount for persistent data:

docker run -it -v $(pwd)/images:/app/images convert_image_to_pdf /app/images

