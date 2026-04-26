import lustre/attribute
import lustre/element.{type Element}

pub fn view(attributes: List(attribute.Attribute(a))) -> Element(a) {
	element.element("hanko-profile", attributes, [])
}