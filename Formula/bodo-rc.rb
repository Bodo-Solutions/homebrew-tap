# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1012.3906-rc/bodo-darwin-arm64"
  version "2026.1012.3906-rc"
  sha256 "a4f38bbdd07b65ecafd7d555106514f654a7d539820056b9558065c261bf06ac"
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
      url "https://cli.bodo-app.com/v/2026.1012.3906-rc/bodo-linux-arm64"
      sha256 "ea2951ad111087608836b511886f6192eb014b4a3ad15ef95db035fd8cbe3d19"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1012.3906-rc/bodo-linux-x64"
      sha256 "262c2591357d750d8ea91346457316126fd7d8202e43c7a9f741ddbefc00fcfb"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
