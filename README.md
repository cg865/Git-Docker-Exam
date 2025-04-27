
About the Application
This Python application takes one or more image files and combines them into a single PDF file in an "output" folder.

## Build Instructions


Build the Docker image:

docker build -t convert_image_to_pdf .

## Run Instructions


Run the container with a volume mount for persistent data:

docker run -it --rm -v $(pwd)/images:/app/images convert_image_to_pdf /app/images

docker run -it --rm -e PDF_NAME=imegesToPDF -v $(pwd)/images:/app/images -v $(pwd)/output:/app/output convert_image_to_p
df /app/images
