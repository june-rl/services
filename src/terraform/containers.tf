resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name = "nginx"

  ports {
      internal = 80
      external = 80
  }

  volumes {
    host_path = "/home/june/certs"
    container_path = "/etc/nginx/certs"
  }

  networks_advanced {
    name = docker_network.nginx.id
  }

}

resource "docker_container" "stirlingpdf" {
  image = docker_image.stirlingpdf.image_id
  name = "spdf"

  networks_advanced {
    name = docker_network.nginx.id
  }

}

resource "docker_container" "memos" {
  image = docker_image.memos.image_id
  name  = "memos"

  networks_advanced {
    name = docker_network.nginx.id
  }

  networks_advanced {
    name = docker_network.memos.id
  }

  env = [
    "MEMOS_DRIVER=postgres",
    "MEMOS_DSN=user=memos password=memos dbname=memosdb host=memos_db sslmode=disable"
  ]

  volumes {
    host_path = "/media/remote/memos_data"
    container_path = "/var/opt/memos"
  }

  user = "1000:1000"

  depends_on = [
    docker_container.memos_db
  ]

}

resource "docker_container" "memos_db" {
  image = docker_image.postgres.image_id
  name = "memos_db"

  networks_advanced {
    name = docker_network.memos.id
  }

  volumes {
    volume_name = docker_volume.memos_pg_data.id
    container_path = "/var/lib/postgresql/data"
  }

  env = [
    "POSTGRES_USER=memos",
    "POSTGRES_PASSWORD=memos",
    "POSTGRES_DB=memosdb"
  ]

}

resource "docker_container" "paperless" {
  image = docker_image.paperless.image_id
  name = "paperless"

  env = [
    "USERMAP_UID=1000",
    "USERMAP_GID=1000",
    "PAPERLESS_URL=https://paperless.june.pet",
    "PAPERLESS_SECRET_KEY=${var.paperless_secret_key}}",
    "PAPERLESS_TIME_ZONE=Europe/London",
    "PAPERLESS_OCR_LANGUAGE=eng",
    "PAPERLESS_REDIS=redis://paperless_redis:6379",
    "PAPERLESS_DBHOST=paperless_db"
  ]

  networks_advanced {
    name = docker_network.paperless.id
  }

  networks_advanced {
    name = docker_network.nginx.id
  }

  depends_on = [
    docker_container.paperless_pg,
    docker_container.paperless_redis
  ]

}

resource "docker_container" "paperless_pg" {
  image = docker_image.postgres.image_id
  name  = "paperless_db"

  env = [
    "POSTGRES_DB=paperless",
    "POSTGRES_USER=paperless",
    "POSTGRES_PASSWORD=paperless"
  ]

  networks_advanced {
      name = docker_network.paperless.id
  }

  volumes {
    volume_name = docker_volume.paperless_pg_data.id
  }

}

resource "docker_container" "paperless_redis" {
  image = docker_image.redis.image_id
  name  = "paperless_redis"

  volumes {
    volume_name = docker_volume.paperless_redis_data.id
  }

  networks_advanced {
    name = docker_network.paperless.id
  }

}