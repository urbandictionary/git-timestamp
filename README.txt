machine:
  services:
    - docker

checkout:
  post:
    - bash <(curl -s https://raw.githubusercontent.com/urbandictionary/git-timestamp/master/git-timestamp.sh) package.json

dependencies:
  cache_directories:
    - "~/docker"

  override:
    - if [[ -e ~/docker/image.tar ]]; then docker load -i ~/docker/image.tar; fi
    - docker-compose build
    - mkdir -p ~/docker; docker save ~~~ImageNames~~~ > ~/docker/image.tar
