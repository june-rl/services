resource "docker_volume" "memos_pg_data" {
  name = "70a05d8204cf139274b6cb27ee3600f111220648d9e0e68f4209cb505c8301fa"
}

resource "docker_volume" "paperless_pg_data" {
  name = "2f6e226546e56d52150ae41207994c685eed75a285077dadc876a401a24a2e86"
}

resource "docker_volume" "paperless_redis_data" {
  name = "da6ef86d21b995d6e931844221f9384cafd23b8db9b00c1c7733c1fcff374a42"
}