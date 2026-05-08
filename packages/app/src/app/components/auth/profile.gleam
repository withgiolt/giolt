import app/lib/makeshift
import lustre/element

pub fn view(attributes: makeshift.Attributes) -> makeshift.Element {
	element.element("hanko-profile", attributes, [])
}
