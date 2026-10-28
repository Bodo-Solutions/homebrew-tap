# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1028.4510-rc/bodo-darwin-arm64"
  version "2026.1028.4510-rc"
  sha256 "3045be572789be400ae0bc97a84f31b58208055d73718d3a25168b3b9a7294a7"
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
      url "https://cli.bodo-app.com/v/2026.1028.4510-rc/bodo-linux-arm64"
      sha256 "67919ed767bc9a334fd25574885c7c96aab3aea6f50d9dc2b5687a5819dff849"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1028.4510-rc/bodo-linux-x64"
      sha256 "2db00de89cc29f51a07b4f477d97e91f92553a414335063c70f71f6e6eece99a"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
