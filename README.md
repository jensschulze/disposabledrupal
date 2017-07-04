# A disposable Drupal 8 instance

## Preliminaries
Execute `./build YOURTAG` where `YOURTAG` is the desired tag for the image being built.

## Usage
`docker run -it --rm -p 8888:8888 jensschulze/disposabledrupal:YOURTAG`

You can now access your fresh Drupal 8 instance at *127.0.0.1:8888*, have fun!

## Site Admin
User: `admin`
Password: `admin`

## Security
Please keep in mind that the server will accept connections from everywhere!
