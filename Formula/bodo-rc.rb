# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1008.3754-rc/bodo-darwin-arm64"
  version "2026.1008.3754-rc"
  sha256 "8d392bb6d7e124254d8250e02c7322e359eead4a748160e64f18edce8a633b65"
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
      url "https://cli.bodo-app.com/v/2026.1008.3754-rc/bodo-linux-arm64"
      sha256 "2d1c2666ff0c16ff3001bfba2b14525d6630e03418add1c5f971aed377ca746a"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1008.3754-rc/bodo-linux-x64"
      sha256 "638711629ae54cdc06ddff5b059ff0224b70a9740575ad595a6f960858270645"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
