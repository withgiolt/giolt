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

pub fn square_terminal(attributes: List(Attribute(a))) {
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
      svg.path([attribute("d", "m7 11 2-2-2-2")]),
      svg.path([attribute("d", "M11 13h4")]),
      svg.rect([
        attribute("ry", "2"),
        attribute("rx", "2"),
        attribute("y", "3"),
        attribute("x", "3"),
        attribute("height", "18"),
        attribute("width", "18"),
      ]),
    ],
  )
}

pub fn plus(attributes: List(Attribute(a))) {
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
      svg.path([attribute("d", "M5 12h14")]),
      svg.path([attribute("d", "M12 5v14")]),
    ],
  )
}

pub fn binoculars(attributes: List(Attribute(a))) {
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
      svg.path([attribute("d", "M10 10h4")]),
      svg.path([attribute("d", "M19 7V4a1 1 0 0 0-1-1h-2a1 1 0 0 0-1 1v3")]),
      svg.path([
        attribute(
          "d",
          "M20 21a2 2 0 0 0 2-2v-3.851c0-1.39-2-2.962-2-4.829V8a1 1 0 0 0-1-1h-4a1 1 0 0 0-1 1v11a2 2 0 0 0 2 2z",
        ),
      ]),
      svg.path([attribute("d", "M 22 16 L 2 16")]),
      svg.path([
        attribute(
          "d",
          "M4 21a2 2 0 0 1-2-2v-3.851c0-1.39 2-2.962 2-4.829V8a1 1 0 0 1 1-1h4a1 1 0 0 1 1 1v11a2 2 0 0 1-2 2z",
        ),
      ]),
      svg.path([attribute("d", "M9 7V4a1 1 0 0 0-1-1H6a1 1 0 0 0-1 1v3")]),
    ],
  )
}
