# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1012.3919/bodo-darwin-arm64"
  version "2026.1012.3919"
  sha256 "7a9727712cd73814eff65a477f6f6f6b7cd5ac7830be66d7b708a4df0cd6f69f"
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
      url "https://cli.bodo-app.com/v/2026.1012.3919/bodo-linux-arm64"
      sha256 "39d4e80edd30e448c63790a284dcd542530d630d3984bc78cf3ef60a936d1489"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1012.3919/bodo-linux-x64"
      sha256 "6659670e0fb6a3fbf5b59962d37e71e0dfd80d7e7f80d57cbbc00fed54031975"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
