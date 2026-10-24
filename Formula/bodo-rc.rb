# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1024.4346-rc/bodo-darwin-arm64"
  version "2026.1024.4346-rc"
  sha256 "271dce540fb6d55a633ce90045d8d6996b990c7219b089004d56a029fd808cdd"
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
      url "https://cli.bodo-app.com/v/2026.1024.4346-rc/bodo-linux-arm64"
      sha256 "23ab69e97b7ab4cb7d57aeb74f2214ef9c3fa73b2e54527bad2ff2d41cfcb63e"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1024.4346-rc/bodo-linux-x64"
      sha256 "b799f52f1cfa771a042dc88d9551150acef83561f28be0c4cf47e4ecdc4d6798"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
