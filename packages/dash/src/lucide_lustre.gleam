import lustre/attribute.{type Attribute, attribute}
import lustre/element/svg

pub fn panel_left_open(attributes: List(Attribute(a))) {
	svg.svg(
		[
			attribute("stroke-linejoin", "round"),
			attribute("stroke-linecap", "round"),
			attribute("stroke-width", "2"),
			attribute("stroke", "currentColor"),
			attribute("fill", "none"),
			attribute("viewBox", "0 0 24 24"),
			attribute("height", "24"),
			attribute("width", "24"),
			..attributes
		],
		[
			svg.rect([
				attribute("rx", "2"),
				attribute("y", "3"),
				attribute("x", "3"),
				attribute("height", "18"),
				attribute("width", "18"),
			]),
			svg.path([attribute("d", "M9 3v18")]),
			svg.path([attribute("d", "m14 9 3 3-3 3")]),
		],
	)
}

pub fn circle_user(attributes: List(Attribute(a))) {
	svg.svg(
		[
			attribute("stroke-linejoin", "round"),
			attribute("stroke-linecap", "round"),
			attribute("stroke-width", "2"),
			attribute("stroke", "currentColor"),
			attribute("fill", "none"),
			attribute("viewBox", "0 0 24 24"),
			attribute("height", "24"),
			attribute("width", "24"),
			..attributes
		],
		[
			svg.circle([
				attribute("r", "10"),
				attribute("cy", "12"),
				attribute("cx", "12"),
			]),
			svg.circle([
				attribute("r", "3"),
				attribute("cy", "10"),
				attribute("cx", "12"),
			]),
			svg.path([
				attribute("d", "M7 20.662V19a2 2 0 0 1 2-2h6a2 2 0 0 1 2 2v1.662"),
			]),
		],
	)
}

pub fn grid_2x2(attributes: List(Attribute(a))) {
	svg.svg(
		[
			attribute("stroke-linejoin", "round"),
			attribute("stroke-linecap", "round"),
			attribute("stroke-width", "2"),
			attribute("stroke", "currentColor"),
			attribute("fill", "none"),
			attribute("viewBox", "0 0 24 24"),
			attribute("height", "24"),
			attribute("width", "24"),
			..attributes
		],
		[
			svg.path([attribute("d", "M12 3v18")]),
			svg.path([attribute("d", "M3 12h18")]),
			svg.rect([
				attribute("rx", "2"),
				attribute("height", "18"),
				attribute("width", "18"),
				attribute("y", "3"),
				attribute("x", "3"),
			]),
		],
	)
}
