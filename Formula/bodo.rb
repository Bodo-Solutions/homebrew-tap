# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-channels.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1116.4744/bodo-darwin-arm64"
  version "2026.1116.4744"
  sha256 "48b53ef69f9f5ef61d685a436d0f5d53ea0637c3f8c81d7bf82f017c8cd762c0"
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
      url "https://cli.bodo-app.com/v/2026.1116.4744/bodo-linux-arm64"
      sha256 "966fd0ccec1bcb80463529389a9325e88608895f7b68222c3baabf0c5052891f"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1116.4744/bodo-linux-x64"
      sha256 "632f13e5bfc1020dea3410db3cc2289904b500b7875153265120b143b6d9bc9f"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
