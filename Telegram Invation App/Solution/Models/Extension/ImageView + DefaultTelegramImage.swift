import UIKit

extension UIImageView {
    func setCirclePlaceholder(
        text: String,
        fontSize: CGFloat = 16,
        weight: UIFont.Weight = .bold,
        textColor: UIColor = .white,
        accentColorId: Int,
        kerning: CGFloat = 0,
        lineBreakMode: NSLineBreakMode = .byClipping
    ) {
        // 1. Gradient color pairs by accentColorId
        let gradients: [(start: UIColor, end: UIColor)] = [
            (UIColor(hex: "#FB7A52"), UIColor(hex: "#FB3F63")),
            (UIColor(hex: "#FEC152"), UIColor(hex: "#FEA84A")),
            (UIColor(hex: "#71A9FA"), UIColor(hex: "#6966FE")),
            (UIColor(hex: "#7FDB6F"), UIColor(hex: "#1DD25F")),
            (UIColor(hex: "#00E3E0"), UIColor(hex: "#00C2C4")),
            (UIColor(hex: "#29CEFE"), UIColor(hex: "#00ABF9")),
            (UIColor(hex: "#E982F8"), UIColor(hex: "#C85FCF"))
        ]
        let idx = max(0, min(6, accentColorId))
        let (startColor, endColor) = gradients[idx]

        // 2. Ensure valid size
        let size = bounds.size
        guard size.width > 0 && size.height > 0 else { return }

        // 3. Configure font (rounded if available)
        var font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        if let rd = font.fontDescriptor.withDesign(.rounded) {
            font = UIFont(descriptor: rd, size: fontSize)
        }

        // 4. Begin bitmap context
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        guard let ctx = UIGraphicsGetCurrentContext() else { return }

        // 5. Draw gradient background (circle or rect)
        let rect = CGRect(origin: .zero, size: size)
        let path = UIBezierPath(ovalIn: rect) // circle
        ctx.saveGState()
        ctx.addPath(path.cgPath)
        ctx.clip()

        let cgColors = [startColor.cgColor, endColor.cgColor] as CFArray
        let locations: [CGFloat] = [0, 1]
        let space = CGColorSpaceCreateDeviceRGB()
        if let gradient = CGGradient(colorsSpace: space, colors: cgColors, locations: locations) {
            let startPoint = CGPoint(x: rect.midX, y: rect.minY)
            let endPoint = CGPoint(x: rect.midX, y: rect.maxY)
            ctx.drawLinearGradient(gradient,
                                   start: startPoint,
                                   end: endPoint,
                                   options: [])
        }
        ctx.restoreGState()

        // 6. Prepare text attributes
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineBreakMode = lineBreakMode

        let attrs: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: textColor,
            .paragraphStyle: paragraphStyle,
            .kern: kerning
        ]

        // 7. Compute initials: one letter for single word, two letters for two+ words
        let parts = text
            .components(separatedBy: .whitespaces)
            .filter { !$0.isEmpty }

        let initials: String = {
            switch parts.count {
            case 0:
                return ""
            case 1:
                return String(parts[0].prefix(1)).uppercased()
            default:
                let first = parts[0].prefix(1)
                let second = parts[1].prefix(1)
                return String((first + second)).uppercased()
            }
        }()

        // 8. Draw initials
        let attributed = NSAttributedString(string: initials, attributes: attrs)
        let textSize = attributed.size()
        let origin = CGPoint(
            x: (size.width  - textSize.width)  / 2,
            y: (size.height - textSize.height) / 2
        )
        attributed.draw(in: CGRect(origin: origin, size: textSize))

        // 9. Set the generated image
        self.image = UIGraphicsGetImageFromCurrentImageContext()
        self.contentMode = .scaleAspectFit
    }
}




