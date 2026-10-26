# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1026.4446-rc/bodo-darwin-arm64"
  version "2026.1026.4446-rc"
  sha256 "9ce6378fe60e6b3a62e00691672769bc5a7a436fafb581c97a42cc4825ecdc64"
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
      url "https://cli.bodo-app.com/v/2026.1026.4446-rc/bodo-linux-arm64"
      sha256 "6b9af95bce3f8a1d2e47194b125c2e03c2acf6273a96f9aff346d421c4a9892c"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1026.4446-rc/bodo-linux-x64"
      sha256 "61299a9dc405ee7b0e6d7963278e14c692ba58578ebd0863bb364572dab0b4dc"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
