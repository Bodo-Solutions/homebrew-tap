# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1006.3659-rc/bodo-darwin-arm64"
  version "2026.1006.3659-rc"
  sha256 "f7d7c02be2e41a7f8d1bf45ab68df7231485bb47f1af8634069f2f88a78b43fe"
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
      url "https://cli.bodo-app.com/v/2026.1006.3659-rc/bodo-linux-arm64"
      sha256 "892ce3d0914dee37fd6dbc05f675f6dfcad663aa0016ad2840a7a6f047e486e3"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1006.3659-rc/bodo-linux-x64"
      sha256 "29584eaebfd28f3cbd498578281b7819ca4055ce2da4b8cce34dc83767849064"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
