resource "docker_volume" "memos_pg_data" {
  name = "b691f4ad2bcb5823cdf86d3bddf7a9e055772719e2a657531f2370fc0abf0200"
}

resource "docker_volume" "paperless_pg_data" {
  name = "8cbad6819b29a02c80a64d1bc39917632992580185c74315aaf4616c40320bf7"
}

resource "docker_volume" "paperless_redis_data" {
  name = "d3081e1c4f25689a934509650f21daf077e5344e9829a98c7beed6769ccce812"
}