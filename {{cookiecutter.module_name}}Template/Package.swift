// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "{{cookiecutter.module_name}}",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "{{cookiecutter.module_name}}",
            targets: ["{{cookiecutter.module_name}}"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "{{cookiecutter.module_name}}",
            dependencies: [],
            path: "{{cookiecutter.module_name}}/Sources",
            resources: [
            .process("Resources/")
            ]
        ),
        .testTarget(
            name: "{{cookiecutter.module_name}}Tests",
            dependencies: ["{{cookiecutter.module_name}}"],
            path: "{{cookiecutter.module_name}}/Tests/Sources"
        ),
    ]
)
