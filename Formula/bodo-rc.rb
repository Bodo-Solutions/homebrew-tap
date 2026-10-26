# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1026.4440-rc/bodo-darwin-arm64"
  version "2026.1026.4440-rc"
  sha256 "9fd5da6023299ff50e3cb2b51c18fa053fe7ed898273c0fe7fe80b33846eb454"
  license :cannot_represent

  livecheck do
    url "https://cli.bodo-app.com/rc/manifest.json"
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
      url "https://cli.bodo-app.com/v/2026.1026.4440-rc/bodo-linux-arm64"
      sha256 "e0bf9d07eb482535b3d61c6f3e24b175f4e22f93f9e925478481bea547a4c6c6"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1026.4440-rc/bodo-linux-x64"
      sha256 "3fa7a04a1715beb05730239038a725536dcd08575e16996513969432425d2d2f"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
