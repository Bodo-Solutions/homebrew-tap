# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1004.3588-rc/bodo-darwin-arm64"
  version "2026.1004.3588-rc"
  sha256 "e1e65e67de59c1a064a18949f06cc5db2a7f5d7439f293f221c24a94d1c8c65e"
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
      url "https://cli.bodo-app.com/v/2026.1004.3588-rc/bodo-linux-arm64"
      sha256 "b702b216795aa8bde3a22f15ba6846d9241f8ebf593f8a6830f67627f29c2ef4"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1004.3588-rc/bodo-linux-x64"
      sha256 "a8ca1b2529a36854b1a80ceb023581e3ed1aa8807a9afcbfd6c2298ba33a34a2"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
