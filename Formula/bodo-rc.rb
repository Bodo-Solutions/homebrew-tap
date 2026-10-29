# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1029.4571-rc/bodo-darwin-arm64"
  version "2026.1029.4571-rc"
  sha256 "55c70878d402f04095c64889ddec8c5c51eb3bbe98612a580b287d767ac46def"
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
      url "https://cli.bodo-app.com/v/2026.1029.4571-rc/bodo-linux-arm64"
      sha256 "33132d44bb52403f79ceb142cb82fc00c919096b014a0d3715f9c006305bafe3"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1029.4571-rc/bodo-linux-x64"
      sha256 "3fa56e65cb6f47e2340a9e58028672b3ead7f063c290dc198df0b3efe222d148"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
