# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1020.4157-rc/bodo-darwin-arm64"
  version "2026.1020.4157-rc"
  sha256 "788d6019f60b4196650aae477946c8c41bc78bc7841ed99459c2a3816c6a66b0"
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
      url "https://cli.bodo-app.com/v/2026.1020.4157-rc/bodo-linux-arm64"
      sha256 "26e6062a6257aa04eb089e24723a2418c23f509241a229678ad3624f747d1563"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1020.4157-rc/bodo-linux-x64"
      sha256 "69b97ec622352142b619ffe305407bb461a63a68f67e9edf12d214cd72ddaa02"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
