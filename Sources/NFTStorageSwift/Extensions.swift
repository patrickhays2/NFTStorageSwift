import Foundation

public extension String {
    func asIPFSLink() -> String {
        let cid = self
        let cidURL = String("https://\(cid).ipfs.dweb.link")
        return cidURL
    }
}
