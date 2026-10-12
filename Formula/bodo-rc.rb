# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1012.3898-rc/bodo-darwin-arm64"
  version "2026.1012.3898-rc"
  sha256 "75266cca824e4c3a9151bd346a45946234e8241baa46c943efe73469831e60ca"
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
      url "https://cli.bodo-app.com/v/2026.1012.3898-rc/bodo-linux-arm64"
      sha256 "f128194af0e68d069be576843c718577f0b4f0c8179052217f6b7f63726d59db"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1012.3898-rc/bodo-linux-x64"
      sha256 "388e01d35737ce22875b5c17f64a653965018e6d98146d52c0e808da142b9a96"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
