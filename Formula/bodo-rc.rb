# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1023.4307-rc/bodo-darwin-arm64"
  version "2026.1023.4307-rc"
  sha256 "337af09c9b2f1dc90f215552768a8cadf57fdbfb494755ddc794147f670717a4"
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
      url "https://cli.bodo-app.com/v/2026.1023.4307-rc/bodo-linux-arm64"
      sha256 "3f868d46edc96de0632d6096a041139a23ad52a0ab273dbf79ac4fa728c4493e"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1023.4307-rc/bodo-linux-x64"
      sha256 "34e843e371989e0ae15411fe6f8d03f45a1378ee4664aea567f6e23becbf65f8"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
