import lustre/attribute.{type Attribute, attribute}
import lustre/element/svg

pub fn rocket_icon(attributes: List(Attribute(a))) {
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
			svg.path([attribute("d", "M12 15v5s3.03-.55 4-2c1.08-1.62 0-5 0-5")]),
			svg.path([
				attribute(
					"d",
					"M4.5 16.5c-1.5 1.26-2 5-2 5s3.74-.5 5-2c.71-.84.7-2.13-.09-2.91a2.18 2.18 0 0 0-2.91-.09",
				),
			]),
			svg.path([
				attribute(
					"d",
					"M9 12a22 22 0 0 1 2-3.95A12.88 12.88 0 0 1 22 2c0 2.72-.78 7.5-6 11a22.4 22.4 0 0 1-4 2z",
				),
			]),
			svg.path([attribute("d", "M9 12H4s.55-3.03 2-4c1.62-1.08 5 .05 5 .05")]),
		],
	)
}

pub fn zap_icon(attributes: List(Attribute(a))) {
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
			svg.path([
				attribute(
					"d",
					"M4 14a1 1 0 0 1-.78-1.63l9.9-10.2a.5.5 0 0 1 .86.46l-1.92 6.02A1 1 0 0 0 13 10h7a1 1 0 0 1 .78 1.63l-9.9 10.2a.5.5 0 0 1-.86-.46l1.92-6.02A1 1 0 0 0 11 14z",
				),
			]),
		],
	)
}

pub fn piggy_bank_icon(attributes: List(Attribute(a))) {
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
			svg.path([
				attribute(
					"d",
					"M11 17h3v2a1 1 0 0 0 1 1h2a1 1 0 0 0 1-1v-3a3.16 3.16 0 0 0 2-2h1a1 1 0 0 0 1-1v-2a1 1 0 0 0-1-1h-1a5 5 0 0 0-2-4V3a4 4 0 0 0-3.2 1.6l-.3.4H11a6 6 0 0 0-6 6v1a5 5 0 0 0 2 4v3a1 1 0 0 0 1 1h2a1 1 0 0 0 1-1z",
				),
			]),
			svg.path([attribute("d", "M16 10h.01")]),
			svg.path([attribute("d", "M2 8v1a2 2 0 0 0 2 2h1")]),
		],
	)
}

pub fn flame_icon(attributes: List(Attribute(a))) {
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
			svg.path([
				attribute(
					"d",
					"M12 3q1 4 4 6.5t3 5.5a1 1 0 0 1-14 0 5 5 0 0 1 1-3 1 1 0 0 0 5 0c0-2-1.5-3-1.5-5q0-2 2.5-4",
				),
			]),
		],
	)
}

pub fn earth_icon(attributes: List(Attribute(a))) {
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
			svg.path([attribute("d", "M21.54 15H17a2 2 0 0 0-2 2v4.54")]),
			svg.path([
				attribute(
					"d",
					"M7 3.34V5a3 3 0 0 0 3 3a2 2 0 0 1 2 2c0 1.1.9 2 2 2a2 2 0 0 0 2-2c0-1.1.9-2 2-2h3.17",
				),
			]),
			svg.path([
				attribute(
					"d",
					"M11 21.95V18a2 2 0 0 0-2-2a2 2 0 0 1-2-2v-1a2 2 0 0 0-2-2H2.05",
				),
			]),
			svg.circle([
				attribute("r", "10"),
				attribute("cy", "12"),
				attribute("cx", "12"),
			]),
		],
	)
}

pub fn wrench_icon(attributes: List(Attribute(a))) {
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
			svg.path([
				attribute(
					"d",
					"M14.7 6.3a1 1 0 0 0 0 1.4l1.6 1.6a1 1 0 0 0 1.4 0l3.106-3.105c.32-.322.863-.22.983.218a6 6 0 0 1-8.259 7.057l-7.91 7.91a1 1 0 0 1-2.999-3l7.91-7.91a6 6 0 0 1 7.057-8.259c.438.12.54.662.219.984z",
				),
			]),
		],
	)
}

pub fn refresh_ccw_icon(attributes: List(Attribute(a))) {
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
			svg.path([
				attribute("d", "M21 12a9 9 0 0 0-9-9 9.75 9.75 0 0 0-6.74 2.74L3 8"),
			]),
			svg.path([attribute("d", "M3 3v5h5")]),
			svg.path([
				attribute("d", "M3 12a9 9 0 0 0 9 9 9.75 9.75 0 0 0 6.74-2.74L21 16"),
			]),
			svg.path([attribute("d", "M16 16h5v5")]),
		],
	)
}

pub fn sticky_note_icon(attributes: List(Attribute(a))) {
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
			svg.path([
				attribute(
					"d",
					"M21 9a2.4 2.4 0 0 0-.706-1.706l-3.588-3.588A2.4 2.4 0 0 0 15 3H5a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2z",
				),
			]),
			svg.path([attribute("d", "M15 3v5a1 1 0 0 0 1 1h5")]),
		],
	)
}
