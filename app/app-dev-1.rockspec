package = "app"
version = "dev-1"

source = {
  url = "git@github.com:mburns/readit.git"
}

description = {
  summary = "Lapis Application",
  homepage = "",
  license = ""
}

dependencies = {
  "lua ~> 5.1",
  "lapis == 1.14.0"
}

build = {
  type = "none"
}
