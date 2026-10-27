# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1027.4472-rc/bodo-darwin-arm64"
  version "2026.1027.4472-rc"
  sha256 "6af941b25cef5e06adf02136a640d94c0d1fe117e0e9950abcba99b2a005c898"
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
      url "https://cli.bodo-app.com/v/2026.1027.4472-rc/bodo-linux-arm64"
      sha256 "ccf2aa4cbb20999c51ff00d389bf6dd90e5100c3d9449687d06d5105bf252b1f"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1027.4472-rc/bodo-linux-x64"
      sha256 "348210d61d1eb5c543e4785c051bc3652dd55e9a3591c146ebb341f307c8f78d"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
