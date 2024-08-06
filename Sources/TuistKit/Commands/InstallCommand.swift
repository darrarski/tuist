import ArgumentParser
import Foundation
import Path

/// A command to install the remote content the project depends on.
public struct InstallCommand: AsyncParsableCommand {
    public init() {}
    public static var configuration: CommandConfiguration {
        CommandConfiguration(
            commandName: "install",
            abstract: "Installs any remote content (e.g. dependencies) necessary to interact with the project."
        )
    }

    @Option(
        name: .shortAndLong,
        help: "The path to the directory or a subdirectory of the project.",
        completion: .directory,
        envKey: .installPath
    )
    var path: String?

    @Flag(
        name: .shortAndLong,
        help: "Instead of simple install, update external content when available.",
        envKey: .installUpdate
    )
    var update: Bool = false

    @Flag(
        name: .shortAndLong,
        help: "Look up dependencies in the Swift Package Registry and use the registry to retrieve them instead of source control when possible.",
        envKey: .installReplaceScmWithRegistry
    )
    var replaceScmWithRegistry: Bool = false

    public func run() async throws {
        try await InstallService().run(
            path: path,
            update: update,
            replaceScmWithRegistry: replaceScmWithRegistry
        )
    }
}
