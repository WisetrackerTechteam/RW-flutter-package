// swift-tools-version: 5.9
// dot_flutter 의 Swift Package Manager 지원. CocoaPods(dot_flutter.podspec)와 공존하며,
// 앱이 SPM 을 켠 경우 이 매니페스트로 통합된다. 소스는 podspec 과 동일한
// Sources/dot_flutter 를 공유한다. 2026-09-18
import PackageDescription

let package = Package(
    name: "dot_flutter",
    platforms: [
        // RW → CouchbaseLite(~> 3.4) 가 iOS 15 이상을 요구함
        .iOS("15.0"),
    ],
    products: [
        .library(name: "dot-flutter", targets: ["dot_flutter"]),
    ],
    dependencies: [
        // 네이티브 SDK(DOT/DOTSession/CouchbaseLite)는 RW-iOS-SPM 을 통해 제공
        .package(url: "https://github.com/WisetrackerTechteam/RW-iOS-SPM.git", from: "1.1.68"),
    ],
    targets: [
        .target(
            name: "dot_flutter",
            dependencies: [
                .product(name: "RW-iOS-SPM", package: "RW-iOS-SPM"),
            ],
            resources: [],
            cSettings: [
                .headerSearchPath("include/dot_flutter"),
            ]
        ),
    ]
)
