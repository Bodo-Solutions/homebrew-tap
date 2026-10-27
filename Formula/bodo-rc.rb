# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1027.4480-rc/bodo-darwin-arm64"
  version "2026.1027.4480-rc"
  sha256 "1c6865047418c17c37609d6b91107f202b1ed999325e7a303d9177c1cd5780b3"
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
      url "https://cli.bodo-app.com/v/2026.1027.4480-rc/bodo-linux-arm64"
      sha256 "ce20c4734c76ee401b11554f604516bbb1117c13b513251c2fce4fc0cc5c0174"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1027.4480-rc/bodo-linux-x64"
      sha256 "6594146d28b7b36b90c10e18b11cbf5f906f777d18c1cd0fe4c0afed289ab025"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
