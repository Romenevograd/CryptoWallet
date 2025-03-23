import Foundation

final class DependenciesContainer: IDependencies {
    let storages: any IStorages
    let repositories: any IRepositories

    init(
        storages: any IStorages,
        repositories: any IRepositories
    ) {
        self.storages = storages
        self.repositories = repositories
    }
}
