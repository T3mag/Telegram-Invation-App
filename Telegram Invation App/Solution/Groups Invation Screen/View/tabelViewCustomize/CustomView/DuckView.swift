import UIKit
import AVFoundation

/// UIView, который всегда сам настраивает плеер при инициализации и обновлении лэйаута
class DuckVideoView: UIView {
    
    // MARK: — Свойства
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?

    // MARK: — Инициализаторы
    override init(frame: CGRect) {
        super.init(frame: frame)
        configurePlayer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configurePlayer()
    }
    
    // MARK: — Настройка плеера
    private func configurePlayer() {
        // 1. Загружаем видео
        guard let path = Bundle.main.path(forResource: "DuckAnimation", ofType: "mov") else {
            debugPrint("⚠️ DuckAnimation.mov not found in bundle")
            return
        }
        let url = URL(fileURLWithPath: path)
        
        // 2. Создаём AVPlayer и слой
        let player = AVPlayer(url: url)
        let layer = AVPlayerLayer(player: player)
        layer.videoGravity = .resizeAspectFill
        
        // 3. Добавляем слой в наш view
        self.layer.addSublayer(layer)
        
        // 4. Сохраняем ссылки и запускаем
        self.player = player
        self.playerLayer = layer
        player.play()
    }

    // MARK: — Обновление фрейма слоя
    override func layoutSubviews() {
        super.layoutSubviews()
        // Убедимся, что слой всегда на весь bounds нашего view
        playerLayer?.frame = bounds
    }
}
