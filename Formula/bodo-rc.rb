# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1025.4370-rc/bodo-darwin-arm64"
  version "2026.1025.4370-rc"
  sha256 "36346e3eecc1d4c6d862c1f24062db42b67596f3a955bc4093465c1e968edab2"
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
      url "https://cli.bodo-app.com/v/2026.1025.4370-rc/bodo-linux-arm64"
      sha256 "df54ca44a5e2f84cc46d064d530097b252ea220e9623abf1f7e0f9af087e1f8e"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1025.4370-rc/bodo-linux-x64"
      sha256 "94270bec6b6525a94295910250283a5ebf65cdb6187af2847e3b5ecf4b59fc07"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
