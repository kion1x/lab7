import UIKit


extension CGPoint {
	static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
		return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
	}

	static func * (point: CGPoint, scale: CGFloat) -> CGPoint {
		return CGPoint(x: point.x * scale, y: point.y * scale)
	}
}


class FunctionView: UIView {

	override func draw(_ rect: CGRect) {
		var bezier: UIBezierPath

		let Zero = CGPoint(x: rect.width/2, y: rect.height/2)
		let Unit = rect.width/8

		// x arrow
		UIColor.red.set()
		bezier = UIBezierPath()
		bezier.move(to: Zero + CGPoint(x: rect.width/2 - Unit/5, y: -4))
		bezier.addLine(to: CGPoint(x: rect.width, y: rect.height/2))
		bezier.addLine(to: Zero + CGPoint(x: rect.width/2 - Unit/5, y: 4))
		bezier.stroke()

		// x axis
		bezier = UIBezierPath()
		bezier.move(to: CGPoint(x: 0, y: rect.height/2))
		bezier.addLine(to: CGPoint(x: rect.width, y: rect.height/2))
		bezier.stroke()

		// x unit
		UIColor.black.set()
		bezier = UIBezierPath()
		bezier.move(to: Zero + CGPoint(x: Unit, y: 4))
		bezier.addLine(to: Zero + CGPoint(x: Unit, y: -4))
		bezier.stroke()

		// y arrow
		UIColor.green.set()
		bezier = UIBezierPath()
		bezier.move(to: Zero + CGPoint(x: -4, y: -rect.height/2 + Unit/5))
		bezier.addLine(to: CGPoint(x: rect.width/2, y: 0))
		bezier.addLine(to: Zero + CGPoint(x: 4, y: -rect.height/2 + Unit/5))
		bezier.stroke()

		// y axis
		bezier = UIBezierPath()
		bezier.move(to: CGPoint(x: rect.width/2, y: rect.height))
		bezier.addLine(to: CGPoint(x: rect.width/2, y: 0))
		bezier.stroke()

		// y unit
		UIColor.black.set()
		bezier = UIBezierPath()
		bezier.move(to: Zero + CGPoint(x: 4, y: -Unit))
		bezier.addLine(to: Zero + CGPoint(x: -4, y: -Unit))
		bezier.stroke()

		// y = cos(x), where x is in range [-pi; pi]
		UIColor.blue.set()
		bezier = UIBezierPath()
        bezier.move(to: Zero + CGPoint(x: CGFloat(-Double.pi) * rect.width / 8, y: rect.height / 8))
        print("shit", rect.width, rect.height)

		for x in stride(from: CGFloat(-Double.pi), to: CGFloat(Double.pi), by: CGFloat(0.001)) {
			let x = CGFloat(x)
			let y = cos(x)
			bezier.addLine(to: Zero + CGPoint(x: x, y: -y) * Unit)
		}
		bezier.stroke()

	}

}


class ChartView: UIView {

	override func draw(_ rect: CGRect) {
		var bezier: UIBezierPath

		var startAngle: CGFloat
		var endAngle: CGFloat

        // blue - 45%
        bezier = UIBezierPath()
        startAngle = 0
        endAngle = CGFloat.pi*2 * 0.45
        bezier.move(to: CGPoint(x: rect.height/2, y: rect.width/2))
        bezier.addArc(withCenter: CGPoint(x: rect.height/2, y: rect.width/2), radius: rect.width/2, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        bezier.addLine(to: CGPoint(x: rect.height/2, y: rect.width/2))
        UIColor.blue.set()
        bezier.fill()
        
        // purple - 5%
        bezier = UIBezierPath()
        startAngle = endAngle
        endAngle += CGFloat.pi*2 * 0.05
        bezier.move(to: CGPoint(x: rect.height/2, y: rect.width/2))
        bezier.addArc(withCenter: CGPoint(x: rect.height/2, y: rect.width/2), radius: rect.width/2, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        bezier.addLine(to: CGPoint(x: rect.height/2, y: rect.width/2))
        UIColor.purple.set()
        bezier.fill()
        
		// yellow - 25%
		bezier = UIBezierPath()
		startAngle = endAngle
		endAngle += CGFloat.pi*2 * 0.25
		bezier.move(to: CGPoint(x: rect.height/2, y: rect.width/2))
		bezier.addArc(withCenter: CGPoint(x: rect.height/2, y: rect.width/2), radius: rect.width/2, startAngle: startAngle, endAngle: endAngle, clockwise: true)
		bezier.addLine(to: CGPoint(x: rect.height/2, y: rect.width/2))
		UIColor.yellow.set()
		bezier.fill()

		// gray - 25%
		bezier = UIBezierPath()
		startAngle = endAngle
		endAngle += CGFloat.pi*2 * 0.25
		bezier.move(to: CGPoint(x: rect.height/2, y: rect.width/2))
		bezier.addArc(withCenter: CGPoint(x: rect.height/2, y: rect.width/2), radius: rect.width/2, startAngle: startAngle, endAngle: endAngle, clockwise: true)
		bezier.addLine(to: CGPoint(x: rect.height/2, y: rect.width/2))
		UIColor.gray.set()
		bezier.fill()

		// inner empty circle
		bezier = UIBezierPath()
		bezier.move(to: CGPoint(x: rect.height/2, y: rect.width/2))
		bezier.addArc(withCenter: CGPoint(x: rect.height/2, y: rect.width/2), radius: rect.width < rect.height ? rect.width/4 : rect.height/4, startAngle: 0, endAngle: CGFloat.pi*2, clockwise: true)
		if #available(iOS 13.0, *) {
			UIColor.systemBackground.set()
		} else {
			UIColor.white.set()
		}
		bezier.fill()
	}

}
