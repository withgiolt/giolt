import wisp
import radiate
import api

pub fn main() {
	let _ = 
		radiate.new()
		|> radiate.add_dir("src")
		|> radiate.on_reload(fn(_, path) {
			wisp.log_info("Change in " <> path <> ", reloading!")
		})
		|> radiate.start()
	
	api.main()
}