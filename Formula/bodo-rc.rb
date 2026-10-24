# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1024.4342-rc/bodo-darwin-arm64"
  version "2026.1024.4342-rc"
  sha256 "f5acf2189eb8db3b4395a0de0c8c14a09454e35344fce5b4c8972ab708d27862"
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
      url "https://cli.bodo-app.com/v/2026.1024.4342-rc/bodo-linux-arm64"
      sha256 "76dcc81906003c4a815bcf46c00749f759f5ea7d2a15bb80072779bf1e877303"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1024.4342-rc/bodo-linux-x64"
      sha256 "778ad2736d26a02d404604507187b5753aaba897d780437c0ba5df7f99b55870"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
