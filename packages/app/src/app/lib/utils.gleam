import envie

pub fn is_dev() {
  envie.get_bool("DEV", False)
}
