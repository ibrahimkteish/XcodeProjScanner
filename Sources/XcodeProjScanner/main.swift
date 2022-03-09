import ArgumentParser
import Parsing
import Foundation


// Define our argumnet parser.
struct XcodeProjScanner: ParsableCommand {
  // Declare expected launch argument(s).

  @Option(help: "Specify the iOS project path")
  var path: String

  @Option(help: "Specify the iOS project .xcodeproj path (optional)")
  var xcodeproj: String?


  func run() throws {
    let sanitizedPath = self.path.dropLastPathComponent
    let sanitizedXcodeproj = self.xcodeproj?.dropLastPathComponent
    try checkXproj(sanitizedPath, sanitizedXcodeproj)
  }
}

func checkXproj(_ path: String, _ xcodeproj: String?) throws {

  let url = URL(fileURLWithPath: path)
  let fileManager = FileManager.default
  guard let enumerator = fileManager.enumerator(atPath: url.path) else {
    throw XcodeProjScannerError.wrongProjectPathArgument
  }

  let xcodeProjectPath = try throwable(xcodeproj) ?? getXcodeProjectPath(in: path)

  var allSwiftFiles = Set<URL>()

  while let element = enumerator.nextObject() as? String {
    guard element.hasSuffix(".swift"), !element.contains("Pods") else { continue }
    let url = URL(fileURLWithPath: path + "/" + element)
    allSwiftFiles.insert(url)
  }

  do {
    let data = try Data(contentsOf: URL(fileURLWithPath: xcodeProjectPath), options: .mappedIfSafe)
    if let fileContent = String(data: data, encoding: .utf8) {

      var lines = [String.SubSequence]()
      for line in fileContent.split(separator: "\n") where line.contains(".swift") {
        lines.append(line.trimmingCharacters(in: .whitespacesAndNewlines)[...])
      }

      var onlySwiftLines = lines.joined(separator: "\n")[...].utf8

      let dotSwiftFile = Parse {
        Skip {
          PrefixThrough(" /* ".utf8)
        }
        PrefixThrough(".swift".utf8)
        Skip {
          PrefixUpTo("\n".utf8)
        }
      }

      let allDotSwiftFiles = Many {
        dotSwiftFile
      } separator: {
        "\n".utf8
      }

      let compacted = try allDotSwiftFiles.parse(&onlySwiftLines).compactMap { String($0) }
      let parsed = Set(compacted)

      var noRef = Set<String>()

      for file in allSwiftFiles {
        if !parsed.contains(file.lastPathComponent) {
          noRef.insert(file.path)
        }
      }

      if noRef.count > 0 {
        print("⚠️  here is the list of unrefrenced swift files")
        for path in noRef {
          print("   \(path)")
        }
      } else {
        print("✅ unrefrenced files weren't found")
      }
      exit(EXIT_SUCCESS)
    }
  } catch { print(error); exit(EXIT_FAILURE) }
}

// run
XcodeProjScanner.main()
