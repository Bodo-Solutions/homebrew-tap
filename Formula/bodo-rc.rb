# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1024.4360-rc/bodo-darwin-arm64"
  version "2026.1024.4360-rc"
  sha256 "644b3ab1e5619b528ba396669c3ec93347a9bafd1ae6fabaa189fc2d7417cfc6"
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
      url "https://cli.bodo-app.com/v/2026.1024.4360-rc/bodo-linux-arm64"
      sha256 "e9088c0836940367a969b96f66c615b34b098d4fe3a67f27154e4a89369943b1"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1024.4360-rc/bodo-linux-x64"
      sha256 "c5fb5aec91bcfa80aa47fb0cc3f2ba70bcc5d3b214400415ce91e39f71186bf3"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
