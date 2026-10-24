# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1024.4328-rc/bodo-darwin-arm64"
  version "2026.1024.4328-rc"
  sha256 "c0ac62bc234d2f34b64f7ed76715ba90971568a0366ba9a7c7e2c361434014fe"
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
      url "https://cli.bodo-app.com/v/2026.1024.4328-rc/bodo-linux-arm64"
      sha256 "010f208f685b0e1719096eddc38aec99bfdb0b725314167b34b022b095eaaba2"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1024.4328-rc/bodo-linux-x64"
      sha256 "ee8cfa9d8e65b0b0630848d283e331b01ab6786eb9f20c307118d57219b19183"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
