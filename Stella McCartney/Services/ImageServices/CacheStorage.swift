//
//  ImagePersistenceService.swift
//  Stella McCartney
//
//  Created by Mauro Romito on 22/10/2019.
//  Copyright © 2019 Mauro Romito. All rights reserved.
//

import Foundation


enum StorageError: Error {
    case notFound
    case cantWrite(Error)
    case cantRead(Error)
    case cantEncode(Error)
    case cantDecode(Error)
}

class CacheStorage {
    private let fileManager: FileManager
    private let path: String
    private var urlPath: URL!
    
    init?(path: String, fileManager: FileManager = FileManager.default) {
        self.path = path
        self.fileManager = fileManager
        if let urlPath = generatePathURL() {
            self.urlPath = urlPath
        } else {
            return nil
        }
    }
    
    func generatePathURL() -> URL? {
        return try? fileManager.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent(path)
    }
    
}

extension CacheStorage {
    
    func save(value: Data, for key: String) throws {
        let url = urlPath.appendingPathComponent(key)
        do {
            try self.createFolders(in: url)
            try value.write(to: url, options: .atomic)
        } catch {
            throw StorageError.cantWrite(error)
        }
    }
    
}

extension CacheStorage {
    private func createFolders(in url: URL) throws {
        let folderUrl = url.deletingLastPathComponent()
        if !fileManager.fileExists(atPath: folderUrl.path) {
            try fileManager.createDirectory(
                at: folderUrl,
                withIntermediateDirectories: true,
                attributes: nil
            )
        }
    }
}

extension CacheStorage {
    
    func load(for key: String) throws -> Data {
        let url = urlPath.appendingPathComponent(key)
        guard let data = fileManager.contents(atPath: url.path) else {
            throw StorageError.notFound
        }
        return data
    }
}

