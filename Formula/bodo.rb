# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1012.3905/bodo-darwin-arm64"
  version "2026.1012.3905"
  sha256 "f44f8f874d6b013d41715af5fbce61c44843055f26dc6e9b7b46724926c8c38d"
  license :cannot_represent

  livecheck do
    url "https://cli.bodo-app.com/stable/manifest.json"
    regex(/^v?(\d+(?:\.\d+)+(?:-rc)?)$/i)
    strategy :json do |json, regex|
      json["version"]&.[](regex, 1)
    end
  end

  on_macos do
    depends_on arch: :arm64 unless Hardware::CPU.in_rosetta2?
  end

  on_linux do
    on_arm do
      url "https://cli.bodo-app.com/v/2026.1012.3905/bodo-linux-arm64"
      sha256 "f8b64789ac1164318079ce336fece9c5fab0de439d8fa8c6c29fae48af1cad98"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1012.3905/bodo-linux-x64"
      sha256 "16a25d42297751031545acc13a6f34d95bb49f029267308dd01d9be615593051"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
