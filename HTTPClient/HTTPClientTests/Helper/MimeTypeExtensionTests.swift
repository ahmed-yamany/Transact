//
//  MimeTypeExtensionTests.swift
//  HTTPClient
//
//  Created by Ahmed Yamany on 21/12/2024.
//
import Foundation
@testable import HTTPClient
import Testing

@Suite("MimeType Tests")
struct MimeTypeExtensionTests {
    @Test("Returns correct extension for known MIME types")
    func testExtensionType_forKnownMimeTypes() throws {
        #expect(MimeType.jpeg.extensionType == "jpeg", "JPEG should return 'jpeg' as the extension")
        #expect(MimeType.png.extensionType == "png", "PNG should return 'png' as the extension")
        #expect(MimeType.mp4.extensionType == "mp4", "MP4 should return 'mp4' as the extension")
        #expect(MimeType.m4a.extensionType == "m4a", "M4A should return 'm4a' as the extension (custom case)")
        #expect(MimeType.json.extensionType == "json", "JSON should return 'json' as the extension")
    }

    @Test("Returns correct extension for audio MIME types")
    func testExtensionType_forAudioMimeTypes() throws {
        #expect(MimeType.mp3.extensionType == "mpeg", "MP3 should return 'mpeg' as the extension")
        #expect(MimeType.wav.extensionType == "wav", "WAV should return 'wav' as the extension")
        #expect(MimeType.flac.extensionType == "flac", "FLAC should return 'flac' as the extension")
    }

    @Test("Returns correct extension for document MIME types")
    func testExtensionType_forDocumentMimeTypes() throws {
        #expect(MimeType.pdf.extensionType == "pdf", "PDF should return 'pdf' as the extension")
        #expect(MimeType.docx.extensionType == "vnd.openxmlformats-officedocument.wordprocessingml.document", "DOCX should return 'wordprocessingml.document' as the extension")
        #expect(MimeType.xlsx.extensionType == "vnd.openxmlformats-officedocument.spreadsheetml.sheet", "XLSX should return 'spreadsheetml.sheet' as the extension")
    }
}
