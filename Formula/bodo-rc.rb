# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1021.4181-rc/bodo-darwin-arm64"
  version "2026.1021.4181-rc"
  sha256 "11d2a0a7e488108a95abff13f4f2dde188a3f4a0f7824f3a8550da343da4f203"
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
      url "https://cli.bodo-app.com/v/2026.1021.4181-rc/bodo-linux-arm64"
      sha256 "028386b2c9d5e165f430f56234b34095d74cd0b3de88a0bf20fc2d0588e923da"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1021.4181-rc/bodo-linux-x64"
      sha256 "4d45654aef3579ee16cab84feb5116e99a57969783df3df5ab6cd25330348bab"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
