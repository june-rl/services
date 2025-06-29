resource "docker_volume" "memos_pg_data" {
  name = "memos_pg_data"
}

resource "docker_volume" "paperless_pg_data" {
  name = "paperless_pgdata"
}

resource "docker_volume" "paperless_redis_data" {
  name = "paperless_redisdata"
}