import Foundation

public struct UploadResponse: Codable {
    let ok: Bool
    let value: NFT
}

public struct UploadFailureResponse: Codable {
    let ok: Bool
    let error:UploadFailureError?
}

public struct UploadFailureError: Codable {
    let message: String
    let code, name: String?
}

public struct DeleteResponse: Codable {
    let ok: Bool
    let error:DeleteError?
}

public struct DeleteError: Codable {
    let message: String
    let code, name: String?
}

public struct NFT: Codable {
    let cid: String?
    let size: Int?
    let created: String?
    let type: String?
    let scope: String?
    let pin: Pin?
    let files: [Files]?
    let deals: [Deal]?
}

public struct Pin:Codable {
    let cid:String?
    let created: String?
    let name: String?
    let size: Int?
    let meta: Meta?
    let status: String?
}

public struct Files: Codable {
    let name: String?
    let type: String?
}

public struct Deal: Codable {
    let status: String?
    let lastChanged:String?
    let chainDealID: Int?
    let datamodelSelector: String?
    let statusText: String?
    let dealActivation:String?
    let dealExpiration: String?
    let miner: String?
    //let network: String
    let pieceCid:String?
    let batchRootCid: String?
}

public struct Meta: Codable {}

public struct SecureStrings:Codable {
    let Strings: [String]
    let Count: Int
    let Length: Int
}
