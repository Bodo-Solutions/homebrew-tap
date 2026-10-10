# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1010.3826-rc/bodo-darwin-arm64"
  version "2026.1010.3826-rc"
  sha256 "6340208c0500b6ee681c46c71f3b7a13e0d59de59ea241ddfc4b57c70c4b175e"
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
      url "https://cli.bodo-app.com/v/2026.1010.3826-rc/bodo-linux-arm64"
      sha256 "c97ac6b743baa1653519ac3ae70988d4797a4f2242c4eb7dde8a324db8c5ea47"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1010.3826-rc/bodo-linux-x64"
      sha256 "3d712678079bd031c7e25c28a65f7c52abc70f5e8cbc959f5bf684642df63909"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
