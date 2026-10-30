# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1030.4662-rc/bodo-darwin-arm64"
  version "2026.1030.4662-rc"
  sha256 "75f211ec360f350acf2ce89d2d00205a84907f69c5aa10f524eb3ba04918b20d"
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
      url "https://cli.bodo-app.com/v/2026.1030.4662-rc/bodo-linux-arm64"
      sha256 "b7cace8ad2c060c4050b56a80aaaf5dceb57fb4976d195c1d3c310b9d0c72280"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1030.4662-rc/bodo-linux-x64"
      sha256 "c3057e50c429b29b373fecd9e2d98007093ade743ebdf0a5aec8ff1f6391fba0"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
