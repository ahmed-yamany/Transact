//
//  File.swift
//
//
//  Created by Ahmed Fathy on 19/11/2023.
//

import Foundation

public enum MimeType: String {
    // Images
    case jpeg = "image/jpeg"
    case png = "image/png"
    case gif = "image/gif"
    case bmp = "image/bmp"
    case webp = "image/webp"
    case tiff = "image/tiff"

    // Audio
    case mp3 = "audio/mpeg"
    case wav = "audio/wav"
    case ogg = "audio/ogg"
    case m4a = "audio/mp4"
    case aac = "audio/aac"
    case flac = "audio/flac"

    // Video
    case mp4 = "video/mp4"
    case mov = "video/quicktime"
    case avi = "video/x-msvideo"
    case mkv = "video/x-matroska"
    case webm = "video/webm"
    case wmv = "video/x-ms-wmv"

    // Documents
    case pdf = "application/pdf"
    case doc = "application/msword"
    case docx = "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
    case xls = "application/vnd.ms-excel"
    case xlsx = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    case ppt = "application/vnd.ms-powerpoint"
    case pptx = "application/vnd.openxmlformats-officedocument.presentationml.presentation"

    // Other types
    case txt = "text/plain"
    case html = "text/html"
    case xml = "text/xml"
    case json = "application/json"

    var extensionType: String {
        switch self {
        case .m4a: return "m4a"
        default:
            return rawValue.split(separator: "/").compactMap({ String($0) }).last ?? ""
        }
    }
}
