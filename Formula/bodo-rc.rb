# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1027.4497-rc/bodo-darwin-arm64"
  version "2026.1027.4497-rc"
  sha256 "5f49d782d9fc52c2695f45837aa6e11baf0556916c52ecbf2fccb5acb7268778"
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
      url "https://cli.bodo-app.com/v/2026.1027.4497-rc/bodo-linux-arm64"
      sha256 "000bd8ee01af5edf21976f6e546ebc3f26fdf00bb85db0947378e85c17cbbb0d"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1027.4497-rc/bodo-linux-x64"
      sha256 "0c4356d4acc6c1e1d225bc91c3b94c34fe3e43553054cb90492d0fcfe6141680"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
